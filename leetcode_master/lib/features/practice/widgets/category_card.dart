import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/category.dart';
import '../../../core/repositories/problem_repository.dart';
import '../../../app/theme.dart';
import 'package:go_router/go_router.dart';
import '../../../core/services/bookmark_service.dart';
import '../../../core/services/progress_service.dart';

final categoryProvider = Provider<Category>((ref) => throw UnimplementedError());
final problemRepositoryProvider = Provider<ProblemRepository>((ref) => ProblemRepository());

final problemCountProvider = FutureProvider<int>((ref) async {
  final category = ref.watch(categoryProvider);
  final repo = ref.watch(problemRepositoryProvider);
  return repo.countByCategory(category.id);
});

final _bookmarkRepoProvider = Provider((ref) => BookmarkRepository());
final _progressRepoProvider = Provider((ref) => ApproachProgressRepository());

class CategoryMetrics {
  final int bookmarkedCount;
  final int completedCount; // problems with all three approaches checked
  const CategoryMetrics({required this.bookmarkedCount, required this.completedCount});
}

final categoryMetricsProvider = FutureProvider<CategoryMetrics>((ref) async {
  final category = ref.watch(categoryProvider);
  final repo = ref.watch(problemRepositoryProvider);
  final bookmarkRepo = ref.watch(_bookmarkRepoProvider);
  final progressRepo = ref.watch(_progressRepoProvider);
  final problems = await repo.fetchProblemsByCategory(category.id);
  int bookmarked = 0;
  int completed = 0;
  for (final p in problems) {
    final isBm = await bookmarkRepo.isBookmarked(p.id);
    if (isBm) bookmarked++;
    final progress = await progressRepo.getProgress(p.id);
    if (progress.length == 3 && progress[0] && progress[1] && progress[2]) {
      completed++;
    }
  }
  return CategoryMetrics(bookmarkedCount: bookmarked, completedCount: completed);
});

class CategoryCard extends ConsumerWidget {
  const CategoryCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = ref.watch(categoryProvider);
    final countAsync = ref.watch(problemCountProvider);

    return GestureDetector(
      onTap: () {
        if (category.premium) {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Premium Category'),
              content: const Text('Unlock premium to access advanced categories.'),
              actions: [
                TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Later')),
                TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Learn More')),
              ],
            ),
          );
          return;
        }
        GoRouter.of(context).go('/practice/category/${category.id}', extra: category);
      },
      child: Card(
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.grid_view, color: kAccentColor),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          category.name,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (category.premium)
                        const Icon(Icons.lock, color: Colors.black45),
                    ],
                  ),
                  const SizedBox(height: 8),
                  countAsync.when(
                    loading: () => const LinearProgressIndicator(minHeight: 6),
                    error: (e, st) => const Text('Problem count unavailable'),
                    data: (count) => Text('$count problems', style: const TextStyle(color: Colors.black54)),
                  ),
                  const SizedBox(height: 4),
                  Consumer(
                    builder: (context, ref, _) {
                      final metrics = ref.watch(categoryMetricsProvider);
                      return metrics.when(
                        loading: () => const LinearProgressIndicator(minHeight: 6),
                        error: (e, st) => const Text('Metrics unavailable', style: TextStyle(color: Colors.black54)),
                        data: (m) => Text('Bookmarks: ${m.bookmarkedCount} • Completed: ${m.completedCount}',
                            style: const TextStyle(color: Colors.black54)),
                      );
                    },
                  ),
                  const Spacer(),
                  Row(
                    children: const [
                      Expanded(child: _DifficultyBar()),
                    ],
                  ),
                ],
              ),
            ),
            if (category.premium)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.08),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _DifficultyBar extends StatelessWidget {
  const _DifficultyBar();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 8,
      child: Row(
        children: const [
          Expanded(flex: 1, child: DecoratedBox(decoration: BoxDecoration(color: kEasyColor))),
          Expanded(flex: 2, child: DecoratedBox(decoration: BoxDecoration(color: kMediumColor))),
          Expanded(flex: 1, child: DecoratedBox(decoration: BoxDecoration(color: kHardColor))),
        ],
      ),
    );
  }
}