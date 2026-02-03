// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approach.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Approach _$ApproachFromJson(Map<String, dynamic> json) => Approach(
  id: json['id'] as String,
  order: (json['order'] as num).toInt(),
  name: json['name'] as String,
  timeComplexity: json['timeComplexity'] as String,
  spaceComplexity: json['spaceComplexity'] as String,
  explanation: json['explanation'] as String,
  code: Approach._codeFromJson(json['code'] as Map<String, dynamic>),
  pattern: json['pattern'] as String?,
);

Map<String, dynamic> _$ApproachToJson(Approach instance) => <String, dynamic>{
  'id': instance.id,
  'order': instance.order,
  'name': instance.name,
  'timeComplexity': instance.timeComplexity,
  'spaceComplexity': instance.spaceComplexity,
  'explanation': instance.explanation,
  'code': Approach._codeToJson(instance.code),
  'pattern': instance.pattern,
};
