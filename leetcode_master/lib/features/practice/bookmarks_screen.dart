import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';

import '../../core/models/problem.dart';
import '../../core/models/difficulty.dart';
import '../../core/repositories/problem_repository.dart';
import '../../core/services/bookmark_service.dart';
import '../../app/theme.dart';

final _problemRepoProvider = Provider((ref) => ProblemRepository());
final _bookmarkRepoProvider = Provider((ref) => BookmarkRepository());

final bookmarkedProblemsProvider = FutureProvider<List<Problem>>((ref) async {
  final repo = ref.watch(_problemRepoProvider);
  final bmRepo = ref.watch(_bookmarkRepoProvider);
  final all = await repo.fetchAllProblems();
  final result = <Problem>[];
  for (final p in all) {
    if (await bmRepo.isBookmarked(p.id)) {
      result.add(p);
    }
  }
  return result;
});

class BookmarksScreen extends ConsumerWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(bookmarkedProblemsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarks'),
      ),
      body: itemsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
        data: (items) {
          if (items.isEmpty) {
            return const Center(child: Text('No bookmarked problems'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final p = items[index];
              return Card(
                child: ListTile(
                  title: Text(p.title),
                  subtitle: Text(_difficultyLabel(p.difficulty)),
                  trailing: p.premium ? const Icon(Icons.lock, color: Colors.black45) : const Icon(Icons.chevron_right),
                  onTap: () {
                    if (p.premium) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Premium problem. Upgrade to unlock.')),
                      );
                      return;
                    }
                    GoRouter.of(context).go('/practice/problem/${p.id}', extra: p);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  String _difficultyLabel(Difficulty d) {
    switch (d) {
      case Difficulty.easy:
        return 'Easy';
      case Difficulty.medium:
        return 'Medium';
      case Difficulty.hard:
        return 'Hard';
    }
    return 'Unknown';
  }
}