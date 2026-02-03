// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
  id: json['id'] as String,
  name: json['name'] as String,
  icon: json['icon'] as String,
  problemCount: (json['problemCount'] as num).toInt(),
  solvedCount: (json['solvedCount'] as num).toInt(),
  isPremium: json['isPremium'] as bool? ?? false,
  description: json['description'] as String?,
);

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'icon': instance.icon,
  'problemCount': instance.problemCount,
  'solvedCount': instance.solvedCount,
  'isPremium': instance.isPremium,
  'description': instance.description,
};
