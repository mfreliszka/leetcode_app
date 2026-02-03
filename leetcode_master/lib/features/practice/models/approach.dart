import 'package:json_annotation/json_annotation.dart';
import '../../../components/lcm_code_block.dart';

part 'approach.g.dart';

@JsonSerializable()
class Approach {
  const Approach({
    required this.id,
    required this.order,
    required this.name,
    required this.timeComplexity,
    required this.spaceComplexity,
    required this.explanation,
    required this.code,
    this.pattern,
  });

  final String id;
  final int order;
  final String name;
  final String timeComplexity;
  final String spaceComplexity;
  final String explanation;
  @JsonKey(fromJson: _codeFromJson, toJson: _codeToJson)
  final Map<CodeLanguage, String> code;
  final String? pattern;

  factory Approach.fromJson(Map<String, dynamic> json) =>
      _$ApproachFromJson(json);

  Map<String, dynamic> toJson() => _$ApproachToJson(this);

  static Map<CodeLanguage, String> _codeFromJson(Map<String, dynamic> json) {
    return {
      if (json['python'] != null) CodeLanguage.python: json['python'] as String,
      if (json['java'] != null) CodeLanguage.java: json['java'] as String,
      if (json['cpp'] != null) CodeLanguage.cpp: json['cpp'] as String,
      if (json['javascript'] != null)
        CodeLanguage.javascript: json['javascript'] as String,
    };
  }

  static Map<String, String> _codeToJson(Map<CodeLanguage, String> code) {
    return {
      for (final entry in code.entries) entry.key.name: entry.value,
    };
  }
}
