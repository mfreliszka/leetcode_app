import 'difficulty.dart';

class Problem {
  final int id;
  final int categoryId;
  final String title;
  final Difficulty difficulty;
  final int estimatedMinutes;
  final bool premium;

  const Problem({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.difficulty,
    required this.estimatedMinutes,
    required this.premium,
  });

  factory Problem.fromMap(Map<String, dynamic> map) => Problem(
        id: map['id'] as int,
        categoryId: map['category_id'] as int,
        title: map['title'] as String,
        difficulty: difficultyFromString(map['difficulty'] as String),
        estimatedMinutes: (map['estimated_minutes'] as int?) ?? 15,
        premium: (map['premium'] as bool?) ?? false,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'category_id': categoryId,
        'title': title,
        'difficulty': difficultyToString(difficulty),
        'estimated_minutes': estimatedMinutes,
        'premium': premium ? 1 : 0,
      };
}