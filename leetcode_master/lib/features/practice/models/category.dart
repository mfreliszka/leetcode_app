import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  const Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.problemCount,
    required this.solvedCount,
    this.isPremium = false,
    this.description,
  });

  final String id;
  final String name;
  final String icon;
  final int problemCount;
  final int solvedCount;
  final bool isPremium;
  final String? description;

  double get progress => problemCount > 0 ? solvedCount / problemCount : 0;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
