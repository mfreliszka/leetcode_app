import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:isar_community/isar.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../db/isar_database.dart';
import '../models/isar/category_isar.dart';
import '../models/isar/problem_isar.dart';

class SeedService {
  static const _seedVersionKey = 'seed_version_isar_v1';
  // Optional external problems directory: prefer runtime .env, fallback to --dart-define
  static String get _dataProblemsDir {
    final v = dotenv.env['DATA_PROBLEMS_DIR']?.trim();
    if (v != null && v.isNotEmpty) return v;
    return const String.fromEnvironment('DATA_PROBLEMS_DIR', defaultValue: '');
  }
  static bool get _skipDbSeed {
    final v = dotenv.env['SKIP_DB_SEED'];
    if (v != null) return v.toLowerCase() == 'true';
    return const bool.fromEnvironment('SKIP_DB_SEED', defaultValue: false);
  }
  static bool get _clearDb {
    final v = dotenv.env['CLEAR_DB'];
    if (v != null) return v.toLowerCase() == 'true';
    return const bool.fromEnvironment('CLEAR_DB', defaultValue: false);
  }

  static Future<void> seedIfNeeded() async {
    final prefs = await SharedPreferences.getInstance();
    if (_clearDb) {
      final isar = await IsarDatabase.instance.isar;
      await isar.writeTxn(() async {
        await isar.clear();
      });
      await prefs.remove(_seedVersionKey);
      // Do not return; proceed to seeding after clearing.
    }

    if (_skipDbSeed) {
      await prefs.remove(_seedVersionKey);
      return;
    }
    final alreadySeeded = prefs.getBool(_seedVersionKey) ?? false;
    if (alreadySeeded) return;

    final isar = await IsarDatabase.instance.isar;

    List<CategoryIsar> categories = [];
    List<ProblemIsar> problems = [];

    // Load categories from dedicated categories.json
    final categoriesFile = await _resolveCategoriesFile();
    if (categoriesFile != null) {
      debugPrint('[SeedService] Using categories file: $categoriesFile');
      categories = await _loadCategoriesFromFile(categoriesFile);
      debugPrint('[SeedService] Loaded ${categories.length} categories from file');
    } else {
      debugPrint('[SeedService] No categories file found; categories will be empty');
    }

    // Load problems from problems directory
    final problemsDir = await _resolveProblemsDir();
    if (problemsDir != null) {
      debugPrint('[SeedService] Using problems dir: $problemsDir');
      problems = await _loadProblemsFromDir(problemsDir);
      debugPrint('[SeedService] Loaded ${problems.length} problems from directory');
    } else {
      debugPrint('[SeedService] No problems directory found; problems will be empty');
    }

    await isar.writeTxn(() async {
      // Upsert all categories and problems found. This makes seeding robust
      // in case a previous run only inserted a subset.
      if (categories.isNotEmpty) {
        await isar.categoryIsars.putAll(categories);
        debugPrint('[SeedService] Upserted ${categories.length} categories');
      }
      if (problems.isNotEmpty) {
        await isar.problemIsars.putAll(problems);
        debugPrint('[SeedService] Upserted ${problems.length} problems');
      }
    });

    await prefs.setBool(_seedVersionKey, true);
  }

  // Resolve the categories file to use for seeding.
  // Priority:
  // 1) Use DATA_PROBLEMS_DIR/categories/categories.json if base directory provided
  // 2) Use default ../data/categories/categories.json relative to cwd
  static Future<String?> _resolveCategoriesFile() async {
    if (_dataProblemsDir.isNotEmpty) {
      final envFile = File(
        _joinPath(_dataProblemsDir, ['categories', 'categories.json']),
      );
      if (await envFile.exists()) {
        return envFile.path;
      }
    }
    try {
      final cwd = Directory.current.path;
      final defaultFile = File(
        _joinPath(cwd, ['..', 'data', 'categories', 'categories.json']),
      );
      if (await defaultFile.exists()) {
        return defaultFile.path;
      }
    } catch (_) {}
    return null;
  }

  // Resolve the problems directory to use for seeding.
  // Priority:
  // 1) Use DATA_PROBLEMS_DIR/problems if base directory provided
  // 2) Use default ../data/problems relative to cwd
  static Future<String?> _resolveProblemsDir() async {
    if (_dataProblemsDir.isNotEmpty) {
      final envDir = Directory(_joinPath(_dataProblemsDir, ['problems']));
      if (await envDir.exists()) {
        return envDir.path;
      }
    }
    try {
      final cwd = Directory.current.path;
      final defaultDir = Directory(
        _joinPath(cwd, ['..', 'data', 'problems']),
      );
      if (await defaultDir.exists()) {
        return defaultDir.path;
      }
    } catch (_) {}
    return null;
  }

  // Load problems from an external directory containing JSON files per problem
  static Future<List<ProblemIsar>> _loadProblemsFromDir(String baseDir) async {
    final dir = Directory(baseDir);
    if (!await dir.exists()) return [];
    final problems = <ProblemIsar>[];
    await for (final entity in dir.list(recursive: true, followLinks: false)) {
      if (entity is File && entity.path.toLowerCase().endsWith('.json')) {
        try {
          final jsonStr = await entity.readAsString();
          final m = json.decode(jsonStr) as Map<String, dynamic>;
          final id = m['id'] as int;
          final p = ProblemIsar(
            id: id,
            categoryId: m['category_id'] as int,
            categoryName: (m['category_name'] as String?) ?? '',
            title: m['title'] as String,
            difficulty: (m['difficulty'] as String?) ?? '',
            estimatedMinutes: (m['estimated_minutes'] as int?) ?? 15,
            isPremium: (m['premium'] == true) || (m['is_premium'] == true),
            isNeetcode150: (m['is_neetcode_150'] == true),
            isBlind75: (m['is_blind_75'] == true),
          );

          // Apply full problem map so we can read both nested content and top-level fields
          _applyContentToProblem(p, m);
          problems.add(p);
        } catch (e) {
          // Log malformed files to aid troubleshooting but continue processing others
          debugPrint('[SeedService] Failed to parse ${entity.path}: $e');
        }
      }
    }
    problems.sort((a, b) => a.id.compareTo(b.id));
    return problems;
  }

  static Future<List<CategoryIsar>> _loadCategoriesFromFile(String path) async {
    final file = File(path);
    if (!await file.exists()) return [];
    final jsonStr = await file.readAsString();
    final list = json.decode(jsonStr) as List<dynamic>;
    final categories = <CategoryIsar>[];
    for (final item in list) {
      final m = item as Map<String, dynamic>;
      categories.add(
        CategoryIsar(
          id: m['id'] as int,
          name: (m['name'] as String?) ?? '',
          premium: (m['premium'] == true),
          description: (m['description'] as String?) ?? '',
        ),
      );
    }
    categories.sort((a, b) => a.id.compareTo(b.id));
    return categories;
  }

  static String _joinPath(String base, List<String> segments) {
    final sep = Platform.pathSeparator;
    final cleaned = segments.join(sep);
    return base.endsWith(sep) ? '$base$cleaned' : '$base$sep$cleaned';
  }

  // No asset-based loading; problems must come from external directory JSON files.

  static void _applyContentToProblem(ProblemIsar p, Map<String, dynamic> problemMap) {
    final content = problemMap['content'] as Map<String, dynamic>?;
    // Map content object (nested)
    final statement = (content?['statement'] as String?) ?? '';
    final inputFormat = (content?['input_format'] as String?) ?? '';
    final outputFormat = (content?['output_format'] as String?) ?? '';

    final constraintsList = (content?['constraints'] as List?) ?? const [];
    final constraints = constraintsList.map((c) {
      final cm = c as Map<String, dynamic>;
      return ConstraintIsar(
        name: (cm['name'] as String?) ?? '',
        value: (cm['value'] as String?) ?? '',
        explanation: (cm['explanation'] as String?) ?? '',
      );
    }).toList();
    final notes = (content?['notes'] as List?)?.cast<String>() ?? const [];
    p.content = ContentIsar(
      statement: statement,
      inputFormat: inputFormat,
      outputFormat: outputFormat,
      constraints: constraints,
      notes: notes,
    );

    // Map approaches (prefer top-level, fallback to nested content)
    final approachesList = (problemMap['approaches'] as List?) ??
        (content?['approaches'] as List?) ??
        const [];
    final approaches = <ApproachIsar>[];
    for (final a in approachesList) {
      final am = a as Map<String, dynamic>;
      final name = am['name'] as String? ?? '';
      final time = am['time'] as String? ?? am['time_complexity'] as String? ?? '';
      final space = am['space'] as String? ?? am['space_complexity'] as String? ?? '';
      final explanation = am['explanation'] as String? ?? '';
      final code = am['code'] as String?; // legacy single-code field
      final pros = (am['pros'] as List?)?.cast<String>() ?? const [];
      final cons = (am['cons'] as List?)?.cast<String>() ?? const [];
      final key = am['key'] as String? ?? _inferApproachKey(name);

      final impls = <ImplementationIsar>[];
      if (code != null && code.isNotEmpty) {
        impls.add(ImplementationIsar(language: 'python', code: code));
      }
      // Optional implementations object per language
      final implMap = am['implementations'] as Map<String, dynamic>?;
      if (implMap != null) {
        for (final entry in implMap.entries) {
          final lang = entry.key;
          final codeStr = (entry.value as Map<String, dynamic>)['code'] as String?;
          if (codeStr != null && codeStr.isNotEmpty) {
            impls.add(ImplementationIsar(language: lang, code: codeStr));
          }
        }
      }

      approaches.add(ApproachIsar(
        key: key,
        name: name,
        timeComplexity: time,
        spaceComplexity: space,
        explanation: explanation,
        pros: pros,
        cons: cons,
        implementations: impls,
      ));
    }
    p.approaches = approaches;

    // Map test cases (prefer top-level, fallback to nested content)
    final testList = (problemMap['test_cases'] as List?) ??
        (content?['test_cases'] as List?) ??
        const [];
    p.testCases = testList.map((t) {
      final tm = t as Map<String, dynamic>;
      final inputObj = tm['input'];
      final outputObj = tm['output'];
      final outputStr = outputObj is String ? outputObj : jsonEncode(outputObj);
      return TestCaseIsar(
        name: (tm['name'] as String?) ?? '',
        inputJson: inputObj is String ? inputObj : jsonEncode(inputObj),
        output: outputStr,
        explanation: (tm['explanation'] as String?) ?? '',
      );
    }).toList();

    // Map comparison table (prefer top-level, fallback to nested content)
    final compTable = (problemMap['comparison_table'] as Map<String, dynamic>?) ??
        (content?['comparison_table'] as Map<String, dynamic>?);
    if (compTable != null) {
      final columns = (compTable['columns'] as List?)?.cast<String>() ??
          const ['Approach', 'Time', 'Space', 'Pros', 'Cons'];
      final rowsList = (compTable['rows'] as List?) ?? const [];
      final rows = rowsList.map((r) {
        final rm = r as Map<String, dynamic>;
        return ComparisonRowIsar(
          approach: (rm['approach'] as String?) ?? '',
          time: (rm['time'] as String?) ?? '',
          space: (rm['space'] as String?) ?? '',
          pros: (rm['pros'] as List?)?.cast<String>() ?? const [],
          cons: (rm['cons'] as List?)?.cast<String>() ?? const [],
        );
      }).toList();
      p.comparisonTable = ComparisonTableIsar(columns: columns, rows: rows);
    }
  }

  static String _inferApproachKey(String name) {
    final n = name.toLowerCase();
    if (n.contains('optimal')) return 'optimal';
    if (n.contains('optimized')) return 'optimized';
    if (n.contains('brute')) return 'brute_force';
    return 'optimized';
  }
}