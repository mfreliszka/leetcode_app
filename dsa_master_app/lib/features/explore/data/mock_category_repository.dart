import '../domain/category_repository.dart';
import '../domain/models.dart';

class MockCategoryRepository implements CategoryRepository {
  @override
  Future<List<Category>> listCategories() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return const [
      Category(id: 'arrays', name: 'Arrays', problemCount: 24),
      Category(id: 'strings', name: 'Strings', problemCount: 18),
      Category(id: 'graphs', name: 'Graphs', problemCount: 30),
      Category(id: 'dp', name: 'Dynamic Programming', problemCount: 22),
    ];
  }
}