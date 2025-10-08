import 'package:isar_community/isar.dart';
import '../db/isar_database.dart';
import '../models/isar/problem_isar.dart';
import '../models/problem.dart';
import '../models/difficulty.dart';
import 'problem_sort.dart';

class ProblemRepository {
  Future<List<Problem>> fetchProblemsByCategory(int categoryId) async {
    final isar = await IsarDatabase.instance.isar;
    final items = await isar.problemIsars.filter().categoryIdEqualTo(categoryId).findAll();
    items.sort((a, b) => a.id.compareTo(b.id));
    return items.map(_mapIsarToProblem).toList();
  }

  Future<int> countByCategory(int categoryId) async {
    final isar = await IsarDatabase.instance.isar;
    final items = await isar.problemIsars.filter().categoryIdEqualTo(categoryId).findAll();
    return items.length;
  }

  Future<List<Problem>> fetchAllProblems() async {
    final isar = await IsarDatabase.instance.isar;
    final items = await isar.problemIsars.where().findAll();
    items.sort((a, b) => a.id.compareTo(b.id));
    return items.map(_mapIsarToProblem).toList();
  }

  Future<Problem?> findById(int id) async {
    final isar = await IsarDatabase.instance.isar;
    final item = await isar.problemIsars.get(id);
    if (item == null) return null;
    return _mapIsarToProblem(item);
  }

  Problem _mapIsarToProblem(ProblemIsar p) => Problem(
        id: p.id,
        categoryId: p.categoryId,
        title: p.title,
        difficulty: difficultyFromString(p.difficulty),
        estimatedMinutes: p.estimatedMinutes,
        premium: p.isPremium,
        isNeetcode150: p.isNeetcode150,
        isBlind75: p.isBlind75,
      );

  Future<List<Problem>> fetchByCategoryFiltered(
    int categoryId, {
    Difficulty? difficulty,
    bool? premiumOnly,
    String? titleQuery,
    ProblemSort sort = ProblemSort.none,
  }) async {
    final isar = await IsarDatabase.instance.isar;
    var q = isar.problemIsars.filter().categoryIdEqualTo(categoryId);

    if (difficulty != null) {
      q = q.difficultyEqualTo(difficulty.name, caseSensitive: false);
    }
    if (premiumOnly == true) {
      q = q.isPremiumEqualTo(true);
    }
    if (titleQuery != null && titleQuery.trim().isNotEmpty) {
      q = q.titleContains(titleQuery.trim(), caseSensitive: false);
    }

    final items = await q.findAll();
    switch (sort) {
      case ProblemSort.titleAsc:
        items.sort((a, b) => a.title.compareTo(b.title));
        break;
      case ProblemSort.titleDesc:
        items.sort((a, b) => b.title.compareTo(a.title));
        break;
      case ProblemSort.minutesAsc:
        items.sort((a, b) => a.estimatedMinutes.compareTo(b.estimatedMinutes));
        break;
      case ProblemSort.minutesDesc:
        items.sort((a, b) => b.estimatedMinutes.compareTo(a.estimatedMinutes));
        break;
      case ProblemSort.difficultyAsc:
        items.sort((a, b) => _rank(a.difficulty).compareTo(_rank(b.difficulty)));
        break;
      case ProblemSort.difficultyDesc:
        items.sort((a, b) => _rank(b.difficulty).compareTo(_rank(a.difficulty)));
        break;
      case ProblemSort.premiumFirst:
        items.sort((a, b) => (b.isPremium ? 1 : 0).compareTo(a.isPremium ? 1 : 0));
        break;
      case ProblemSort.none:
        items.sort((a, b) => a.id.compareTo(b.id));
        break;
    }
    return items.map(_mapIsarToProblem).toList();
  }

  int _rank(String difficulty) => switch (difficulty.toLowerCase()) {
        'easy' => 0,
        'medium' => 1,
        'hard' => 2,
        _ => 3,
      };

  Future<List<Problem>> fetchNeetcode150ByCategory(
    int categoryId, {
    Difficulty? difficulty,
    String? titleQuery,
    ProblemSort sort = ProblemSort.none,
  }) async {
    final isar = await IsarDatabase.instance.isar;
    var q = isar.problemIsars.filter().categoryIdEqualTo(categoryId).isNeetcode150EqualTo(true);
    if (difficulty != null) {
      q = q.difficultyEqualTo(difficulty.name, caseSensitive: false);
    }
    if (titleQuery != null && titleQuery.trim().isNotEmpty) {
      q = q.titleContains(titleQuery.trim(), caseSensitive: false);
    }
    final items = await q.findAll();
    switch (sort) {
      case ProblemSort.titleAsc:
        items.sort((a, b) => a.title.compareTo(b.title));
        break;
      case ProblemSort.titleDesc:
        items.sort((a, b) => b.title.compareTo(a.title));
        break;
      case ProblemSort.minutesAsc:
        items.sort((a, b) => a.estimatedMinutes.compareTo(b.estimatedMinutes));
        break;
      case ProblemSort.minutesDesc:
        items.sort((a, b) => b.estimatedMinutes.compareTo(a.estimatedMinutes));
        break;
      case ProblemSort.difficultyAsc:
        items.sort((a, b) => _rank(a.difficulty).compareTo(_rank(b.difficulty)));
        break;
      case ProblemSort.difficultyDesc:
        items.sort((a, b) => _rank(b.difficulty).compareTo(_rank(a.difficulty)));
        break;
      case ProblemSort.premiumFirst:
        items.sort((a, b) => (b.isPremium ? 1 : 0).compareTo(a.isPremium ? 1 : 0));
        break;
      case ProblemSort.none:
        items.sort((a, b) => a.id.compareTo(b.id));
        break;
    }
    return items.map(_mapIsarToProblem).toList();
  }

  Future<List<Problem>> fetchBlind75ByCategory(
    int categoryId, {
    Difficulty? difficulty,
    String? titleQuery,
    ProblemSort sort = ProblemSort.none,
  }) async {
    final isar = await IsarDatabase.instance.isar;
    var q = isar.problemIsars.filter().categoryIdEqualTo(categoryId).isBlind75EqualTo(true);
    if (difficulty != null) {
      q = q.difficultyEqualTo(difficulty.name, caseSensitive: false);
    }
    if (titleQuery != null && titleQuery.trim().isNotEmpty) {
      q = q.titleContains(titleQuery.trim(), caseSensitive: false);
    }
    final items = await q.findAll();
    switch (sort) {
      case ProblemSort.titleAsc:
        items.sort((a, b) => a.title.compareTo(b.title));
        break;
      case ProblemSort.titleDesc:
        items.sort((a, b) => b.title.compareTo(a.title));
        break;
      case ProblemSort.minutesAsc:
        items.sort((a, b) => a.estimatedMinutes.compareTo(b.estimatedMinutes));
        break;
      case ProblemSort.minutesDesc:
        items.sort((a, b) => b.estimatedMinutes.compareTo(a.estimatedMinutes));
        break;
      case ProblemSort.difficultyAsc:
        items.sort((a, b) => _rank(a.difficulty).compareTo(_rank(b.difficulty)));
        break;
      case ProblemSort.difficultyDesc:
        items.sort((a, b) => _rank(b.difficulty).compareTo(_rank(a.difficulty)));
        break;
      case ProblemSort.premiumFirst:
        items.sort((a, b) => (b.isPremium ? 1 : 0).compareTo(a.isPremium ? 1 : 0));
        break;
      case ProblemSort.none:
        items.sort((a, b) => a.id.compareTo(b.id));
        break;
    }
    return items.map(_mapIsarToProblem).toList();
  }
}