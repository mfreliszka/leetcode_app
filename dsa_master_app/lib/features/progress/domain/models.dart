import 'package:flutter/foundation.dart';

@immutable
class ProgressMetrics {
  final int solvedCount;
  final int attemptedCount;
  final int categoriesCompleted;
  final int currentStreakDays;
  final List<bool> last28DaysActivity;
  final Map<String, int> solvedPerCategory;
  final Map<String, int> solvedPerCategoryByName;

  const ProgressMetrics({
    required this.solvedCount,
    required this.attemptedCount,
    required this.categoriesCompleted,
    this.currentStreakDays = 0,
    this.last28DaysActivity = const [],
    this.solvedPerCategory = const {},
    this.solvedPerCategoryByName = const {},
  });
}