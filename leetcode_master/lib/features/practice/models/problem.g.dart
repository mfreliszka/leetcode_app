// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'problem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Problem _$ProblemFromJson(Map<String, dynamic> json) => Problem(
  id: json['id'] as String,
  title: json['title'] as String,
  categoryId: json['categoryId'] as String? ?? '',
  difficulty: Problem._difficultyFromJson(json['difficulty'] as String),
  isSolved: json['isSolved'] as bool? ?? false,
  isPremium: json['isPremium'] as bool? ?? false,
  order: (json['order'] as num?)?.toInt() ?? 0,
  questionSetIds:
      (json['questionSetIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$ProblemToJson(Problem instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'categoryId': instance.categoryId,
  'difficulty': Problem._difficultyToJson(instance.difficulty),
  'isSolved': instance.isSolved,
  'isPremium': instance.isPremium,
  'order': instance.order,
  'questionSetIds': instance.questionSetIds,
};

ProblemDetail _$ProblemDetailFromJson(Map<String, dynamic> json) =>
    ProblemDetail(
      id: json['id'] as String,
      title: json['title'] as String,
      difficulty: ProblemDetail._difficultyFromJson(
        json['difficulty'] as String,
      ),
      description: json['description'] as String,
      examples: (json['examples'] as List<dynamic>)
          .map((e) => Example.fromJson(e as Map<String, dynamic>))
          .toList(),
      constraints: (json['constraints'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      approaches: (json['approaches'] as List<dynamic>)
          .map((e) => Approach.fromJson(e as Map<String, dynamic>))
          .toList(),
      isPremium: json['isPremium'] as bool? ?? false,
    );

Map<String, dynamic> _$ProblemDetailToJson(ProblemDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'difficulty': ProblemDetail._difficultyToJson(instance.difficulty),
      'description': instance.description,
      'examples': instance.examples,
      'constraints': instance.constraints,
      'approaches': instance.approaches,
      'isPremium': instance.isPremium,
    };

Example _$ExampleFromJson(Map<String, dynamic> json) => Example(
  input: json['input'] as String,
  output: json['output'] as String,
  explanation: json['explanation'] as String?,
);

Map<String, dynamic> _$ExampleToJson(Example instance) => <String, dynamic>{
  'input': instance.input,
  'output': instance.output,
  'explanation': instance.explanation,
};
