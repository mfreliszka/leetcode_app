import 'difficulty.dart';

class Problem {
  final int id;
  final int categoryId;
  final String title;
  final Difficulty difficulty;
  final int estimatedMinutes;
  final bool premium;
  final bool isNeetcode150;
  final bool isBlind75;

  const Problem({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.difficulty,
    required this.estimatedMinutes,
    required this.premium,
    this.isNeetcode150 = false,
    this.isBlind75 = false,
  });

  factory Problem.fromMap(Map<String, dynamic> map) => Problem(
        id: map['id'] as int,
        categoryId: map['category_id'] as int,
        title: map['title'] as String,
        difficulty: difficultyFromString(map['difficulty'] as String),
        estimatedMinutes: (map['estimated_minutes'] as int?) ?? 15,
        premium: (map['premium'] as bool?) ?? false,
        isNeetcode150: (map['is_neetcode_150'] as bool?) ?? false,
        isBlind75: (map['is_blind_75'] as bool?) ?? false,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'category_id': categoryId,
        'title': title,
        'difficulty': difficultyToString(difficulty),
        'estimated_minutes': estimatedMinutes,
        'premium': premium ? 1 : 0,
        'is_neetcode_150': isNeetcode150 ? 1 : 0,
        'is_blind_75': isBlind75 ? 1 : 0,
      };
}