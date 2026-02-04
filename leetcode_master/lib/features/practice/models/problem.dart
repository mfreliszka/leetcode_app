import 'package:json_annotation/json_annotation.dart';
import '../../../components/lcm_badge.dart';
import 'approach.dart';

part 'problem.g.dart';

@JsonSerializable()
class Problem {
  const Problem({
    required this.id,
    required this.title,
    this.categoryId = '',
    required this.difficulty,
    this.isSolved = false,
    this.isPremium = false,
    this.order = 0,
    this.questionSetIds = const [],
  });

  final String id;
  final String title;
  final String categoryId;
  @JsonKey(fromJson: _difficultyFromJson, toJson: _difficultyToJson)
  final Difficulty difficulty;
  final bool isSolved;
  final bool isPremium;
  final int order;

  /// Foreign keys to QuestionSet IDs (e.g., ["blind_75", "neetcode_150"])
  final List<String> questionSetIds;

  factory Problem.fromJson(Map<String, dynamic> json) =>
      _$ProblemFromJson(json);

  Map<String, dynamic> toJson() => _$ProblemToJson(this);

  static Difficulty _difficultyFromJson(String value) {
    switch (value.toLowerCase()) {
      case 'easy':
        return Difficulty.easy;
      case 'medium':
        return Difficulty.medium;
      case 'hard':
        return Difficulty.hard;
      default:
        return Difficulty.medium;
    }
  }

  static String _difficultyToJson(Difficulty difficulty) {
    return difficulty.name;
  }
}

@JsonSerializable()
class ProblemDetail {
  const ProblemDetail({
    required this.id,
    required this.title,
    required this.difficulty,
    required this.description,
    required this.examples,
    required this.constraints,
    required this.approaches,
    this.isPremium = false,
  });

  final String id;
  final String title;
  @JsonKey(fromJson: _difficultyFromJson, toJson: _difficultyToJson)
  final Difficulty difficulty;
  final String description;
  final List<Example> examples;
  final List<String> constraints;
  final List<Approach> approaches;
  final bool isPremium;

  factory ProblemDetail.fromJson(Map<String, dynamic> json) =>
      _$ProblemDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ProblemDetailToJson(this);

  static Difficulty _difficultyFromJson(String value) {
    switch (value.toLowerCase()) {
      case 'easy':
        return Difficulty.easy;
      case 'medium':
        return Difficulty.medium;
      case 'hard':
        return Difficulty.hard;
      default:
        return Difficulty.medium;
    }
  }

  static String _difficultyToJson(Difficulty difficulty) {
    return difficulty.name;
  }
}

@JsonSerializable()
class Example {
  const Example({required this.input, required this.output, this.explanation});

  final String input;
  final String output;
  final String? explanation;

  factory Example.fromJson(Map<String, dynamic> json) =>
      _$ExampleFromJson(json);

  Map<String, dynamic> toJson() => _$ExampleToJson(this);
}
