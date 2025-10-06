import 'dart:convert';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart' show rootBundle;
import 'package:sqflite/sqflite.dart';

import '../db/app_database.dart';
import '../models/problem.dart';

class ProblemRepository {
  Future<List<Problem>> fetchProblemsByCategory(int categoryId) async {
    if (kIsWeb) {
      final jsonStr = await rootBundle.loadString('assets/data/problems.json');
      final list = json.decode(jsonStr) as List<dynamic>;
      return list
          .map((e) => Problem.fromMap(e as Map<String, dynamic>))
          .where((p) => p.categoryId == categoryId)
          .toList();
    }
    final db = await AppDatabase.instance.database;
    final rows = await db.query('problems', where: 'category_id = ?', whereArgs: [categoryId]);
    return rows.map((e) => Problem.fromMap(e)).toList();
  }

  Future<int> countByCategory(int categoryId) async {
    if (kIsWeb) {
      final items = await fetchProblemsByCategory(categoryId);
      return items.length;
    }
    final db = await AppDatabase.instance.database;
    final result = await db.rawQuery('SELECT COUNT(*) as c FROM problems WHERE category_id = ?', [categoryId]);
    return (result.first['c'] as int?) ?? 0;
  }

  Future<List<Problem>> fetchAllProblems() async {
    if (kIsWeb) {
      final jsonStr = await rootBundle.loadString('assets/data/problems.json');
      final list = json.decode(jsonStr) as List<dynamic>;
      return list.map((e) => Problem.fromMap(e as Map<String, dynamic>)).toList();
    }
    final db = await AppDatabase.instance.database;
    final rows = await db.query('problems', orderBy: 'id ASC');
    return rows.map((e) => Problem.fromMap(e)).toList();
  }

  Future<Problem?> findById(int id) async {
    if (kIsWeb) {
      final jsonStr = await rootBundle.loadString('assets/data/problems.json');
      final list = json.decode(jsonStr) as List<dynamic>;
      for (final e in list) {
        final map = e as Map<String, dynamic>;
        if ((map['id'] as int?) == id) {
          return Problem.fromMap(map);
        }
      }
      return null;
    }
    final db = await AppDatabase.instance.database;
    final rows = await db.query('problems', where: 'id = ?', whereArgs: [id], limit: 1);
    if (rows.isEmpty) return null;
    return Problem.fromMap(rows.first);
  }
}