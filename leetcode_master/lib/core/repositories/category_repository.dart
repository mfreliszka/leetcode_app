import 'dart:convert';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart' show rootBundle;
import 'package:sqflite/sqflite.dart';

import '../db/app_database.dart';
import '../models/category.dart';

class CategoryRepository {
  Future<List<Category>> fetchCategories() async {
    if (kIsWeb) {
      final jsonStr = await rootBundle.loadString('assets/data/categories.json');
      final list = json.decode(jsonStr) as List<dynamic>;
      return list.map((e) => Category.fromMap(e as Map<String, dynamic>)).toList();
    }
    final db = await AppDatabase.instance.database;
    final rows = await db.query('categories', orderBy: 'id ASC');
    return rows.map((e) => Category.fromMap(e)).toList();
  }

  Future<Category?> findById(int id) async {
    if (kIsWeb) {
      final jsonStr = await rootBundle.loadString('assets/data/categories.json');
      final list = json.decode(jsonStr) as List<dynamic>;
      for (final e in list) {
        final map = e as Map<String, dynamic>;
        if ((map['id'] as int?) == id) {
          return Category.fromMap(map);
        }
      }
      return null;
    }
    final db = await AppDatabase.instance.database;
    final rows = await db.query('categories', where: 'id = ?', whereArgs: [id], limit: 1);
    if (rows.isEmpty) return null;
    return Category.fromMap(rows.first);
  }
}