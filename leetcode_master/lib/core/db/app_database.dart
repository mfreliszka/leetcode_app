import 'dart:async';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  AppDatabase._();
  static final AppDatabase instance = AppDatabase._();

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _init();
    return _db!;
  }

  Future<Database> _init() async {
    final docs = await getApplicationDocumentsDirectory();
    final dbPath = p.join(docs.path, 'leetcode_master.db');
    return openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE categories (
            id INTEGER PRIMARY KEY,
            name TEXT NOT NULL,
            premium INTEGER NOT NULL,
            description TEXT
          );
        ''');

        await db.execute('''
          CREATE TABLE problems (
            id INTEGER PRIMARY KEY,
            category_id INTEGER NOT NULL,
            title TEXT NOT NULL,
            difficulty TEXT NOT NULL,
            estimated_minutes INTEGER NOT NULL,
            premium INTEGER NOT NULL,
            FOREIGN KEY(category_id) REFERENCES categories(id)
          );
        ''');
      },
    );
  }
}