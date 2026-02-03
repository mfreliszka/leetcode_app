import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';

import '../models/isar/problem_isar.dart';
import '../models/isar/category_isar.dart';

class IsarDatabase {
  IsarDatabase._();
  static final IsarDatabase instance = IsarDatabase._();

  Isar? _isar;

  Future<Isar> get isar async {
    if (_isar != null) return _isar!;
    _isar = await _open();
    return _isar!;
  }

  Future<Isar> _open() async {
    // Open Isar with all collection schemas. No explicit directory required.
    final schemas = [
      ProblemIsarSchema,
      CategoryIsarSchema,
      QuizPatternMapIsarSchema,
      QuizApproachIdentifierIsarSchema,
      QuizComplexityFactsIsarSchema,
    ];

    if (kIsWeb) {
      // Web support is limited in v3; pass empty directory to satisfy signature.
      return await Isar.open(schemas, directory: '');
    } else {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(schemas, directory: dir.path);
    }
  }
}