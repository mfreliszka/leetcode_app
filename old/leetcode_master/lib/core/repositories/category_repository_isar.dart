import 'package:isar_community/isar.dart';
import '../db/isar_database.dart';
import '../models/isar/category_isar.dart';
import '../models/category.dart';

class CategoryRepository {
  Future<List<Category>> fetchCategories() async {
    final isar = await IsarDatabase.instance.isar;
    final items = await isar.categoryIsars.where().findAll();
    items.sort((a, b) => a.id.compareTo(b.id));
    return items.map(_mapIsarToCategory).toList();
  }

  Future<Category?> findById(int id) async {
    final isar = await IsarDatabase.instance.isar;
    final item = await isar.categoryIsars.get(id);
    if (item == null) return null;
    return _mapIsarToCategory(item);
  }

  Category _mapIsarToCategory(CategoryIsar c) => Category(
        id: c.id,
        name: c.name,
        premium: c.premium,
        description: c.description ?? '',
      );
}