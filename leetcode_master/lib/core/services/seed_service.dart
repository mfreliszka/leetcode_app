import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../db/app_database.dart';

class SeedService {
  static const _seedVersionKey = 'seed_version_v1';

  static Future<void> seedIfNeeded() async {
    final prefs = await SharedPreferences.getInstance();
    final alreadySeeded = prefs.getBool(_seedVersionKey) ?? false;
    if (alreadySeeded) return;

    final db = await AppDatabase.instance.database;
    await _seedCategories(db);
    await _seedProblems(db);

    await prefs.setBool(_seedVersionKey, true);
  }

  static Future<void> _seedCategories(Database db) async {
    final jsonStr = await rootBundle.loadString('assets/data/categories.json');
    final list = json.decode(jsonStr) as List<dynamic>;
    final batch = db.batch();
    for (final item in list) {
      batch.insert('categories', {
        'id': item['id'],
        'name': item['name'],
        'premium': item['premium'] == true ? 1 : 0,
        'description': item['description'] ?? '',
      });
    }
    await batch.commit(noResult: true);
  }

  static Future<void> _seedProblems(Database db) async {
    final jsonStr = await rootBundle.loadString('assets/data/problems.json');
    final list = json.decode(jsonStr) as List<dynamic>;
    final batch = db.batch();
    for (final item in list) {
      batch.insert('problems', {
        'id': item['id'],
        'category_id': item['category_id'],
        'title': item['title'],
        'difficulty': item['difficulty'],
        'estimated_minutes': item['estimated_minutes'] ?? 15,
        'premium': item['premium'] == true ? 1 : 0,
      });
    }
    await batch.commit(noResult: true);
  }
}