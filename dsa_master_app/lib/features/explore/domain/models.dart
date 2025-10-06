import 'package:flutter/foundation.dart';

@immutable
class Category {
  final String id;
  final String name;
  final int problemCount;
  const Category({required this.id, required this.name, required this.problemCount});
}

@immutable
class Problem {
  final String id;
  final String title;
  final String difficulty; // e.g., Easy/Medium/Hard
  const Problem({required this.id, required this.title, required this.difficulty});
}