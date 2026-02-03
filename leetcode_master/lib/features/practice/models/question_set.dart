import 'package:json_annotation/json_annotation.dart';

part 'question_set.g.dart';

/// Represents a curated set of problems (e.g., Blind 75, NeetCode 150)
@JsonSerializable(fieldRename: FieldRename.snake)
class QuestionSet {
  const QuestionSet({
    required this.id,
    required this.name,
    this.description,
    this.problemCount = 0,
  });

  /// Unique identifier for the set
  final String id;

  /// Display name (e.g., "Blind 75", "NeetCode 150")
  final String name;

  /// Optional description of the set
  final String? description;

  /// Number of problems in this set
  final int problemCount;

  factory QuestionSet.fromJson(Map<String, dynamic> json) =>
      _$QuestionSetFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionSetToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionSet && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
