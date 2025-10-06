import 'package:flutter/foundation.dart';

@immutable
class Approach {
  final String id;
  final String problemId;
  final String type; // brute_force, optimized, optimal
  final String timeComplexity;
  final String spaceComplexity;
  final String explanation;
  final String code;
  final List<String> keyInsights;
  final String? language; // optional explicit language from DB

  const Approach({
    required this.id,
    required this.problemId,
    required this.type,
    required this.timeComplexity,
    required this.spaceComplexity,
    required this.explanation,
    required this.code,
    required this.keyInsights,
    this.language,
  });
}

@immutable
class Hint {
  final String id;
  final String problemId;
  final String text;

  const Hint({
    required this.id,
    required this.problemId,
    required this.text,
  });
}