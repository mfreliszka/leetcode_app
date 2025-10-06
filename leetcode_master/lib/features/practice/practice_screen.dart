import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/models/category.dart';
import '../../core/repositories/category_repository.dart';
import '../../core/repositories/problem_repository.dart';
import 'widgets/category_card.dart';

final _categoryRepoProvider = Provider((ref) => CategoryRepository());
final _problemRepoProvider = Provider((ref) => ProblemRepository());
final categoriesProvider = FutureProvider<List<Category>>((ref) async {
  final repo = ref.watch(_categoryRepoProvider);
  return repo.fetchCategories();
});

class PracticeScreen extends ConsumerWidget {
  const PracticeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoriesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Practice'),
        actions: [
          IconButton(
            tooltip: 'Bookmarks',
            icon: const Icon(Icons.bookmark_outline),
            onPressed: () {
              GoRouter.of(context).go('/practice/bookmarks');
            },
          ),
        ],
      ),
      body: categoriesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
        data: (categories) {
          return LayoutBuilder(
            builder: (context, constraints) {
              final isLandscape = constraints.maxWidth > constraints.maxHeight;
              final crossAxisCount = isLandscape ? 3 : 2;
              return GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.1,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return ProviderScope(
                    overrides: [
                      categoryProvider.overrideWithValue(category),
                      problemRepositoryProvider.overrideWithValue(ref.read(_problemRepoProvider)),
                    ],
                    child: const CategoryCard(),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}