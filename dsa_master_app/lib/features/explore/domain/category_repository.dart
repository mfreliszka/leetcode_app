import 'models.dart';

abstract class CategoryRepository {
  Future<List<Category>> listCategories();
}