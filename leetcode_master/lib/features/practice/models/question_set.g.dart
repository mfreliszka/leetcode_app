// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_set.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionSet _$QuestionSetFromJson(Map<String, dynamic> json) => QuestionSet(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  problemCount: (json['problem_count'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$QuestionSetToJson(QuestionSet instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'problem_count': instance.problemCount,
    };
