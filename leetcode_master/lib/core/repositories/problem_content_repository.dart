import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/problem_content.dart';

class ProblemContentRepository {
  Future<ProblemContent?> fetchByProblemId(int id) async {
    try {
      final path = 'assets/data/problem_content/$id.json';
      final jsonStr = await rootBundle.loadString(path);
      final map = json.decode(jsonStr) as Map<String, dynamic>;
      return ProblemContent.fromMap(map);
    } catch (_) {
      return null; // No content available yet
    }
  }
}