import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Riverpod 3.0 moved StateProvider to the legacy import
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';
import '../../core/services/bookmark_service.dart';
import '../../core/services/progress_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/models/category.dart';
import '../../core/models/problem.dart';
import '../../core/models/difficulty.dart';
import '../../core/repositories/problem_repository_isar.dart';

final _problemRepoProvider = Provider((ref) => ProblemRepository());
final _bookmarkRepoProvider = Provider((ref) => BookmarkRepository());
final _progressRepoProvider = Provider((ref) => ApproachProgressRepository());

// Problem list filters for well-known curated lists
enum ListFilter { none, neetcode150, blind75 }

// Sorting options for problem list
enum SortOption {
  none,
  difficultyAsc,
  difficultyDesc,
  progressAsc,
  progressDesc,
  neetcodeFirst,
  blindFirst,
}

// Persistence key for selected sort option
const String _kSortPrefKey = 'category_selected_sort_option_v1';
// Persistence keys for filters and search
const String _kFilterDifficultyKey = 'category_filter_difficulty_v1';
const String _kFilterListKey = 'category_filter_list_v1';
const String _kFilterBookmarkedOnlyKey = 'category_filter_bookmarked_only_v1';
const String _kFilterCompletedOnlyKey = 'category_filter_completed_only_v1';
const String _kFilterHideCompletedKey = 'category_filter_hide_completed_v1';
const String _kSearchQueryKey = 'category_search_query_v1';
bool _seededFilters = false;

final selectedDifficultyProvider = StateProvider<Difficulty?>((ref) => null);
final selectedListProvider = StateProvider<ListFilter>(
  (ref) => ListFilter.none,
);
final searchQueryProvider = StateProvider<String>((ref) => '');
final bookmarkedOnlyProvider = StateProvider<bool>((ref) => false);
final completedOnlyProvider = StateProvider<bool>((ref) => false);
final hideCompletedProvider = StateProvider<bool>((ref) => false);
final selectedSortProvider = StateProvider<SortOption>(
  (ref) => SortOption.none,
);
final problemsByCategoryProvider = FutureProvider.family<List<Problem>, int>((
  ref,
  categoryId,
) async {
  final repo = ref.watch(_problemRepoProvider);
  return repo.fetchProblemsByCategory(categoryId);
});

final bookmarkedIdsByCategoryProvider = FutureProvider.family<Set<int>, int>((
  ref,
  categoryId,
) async {
  final repo = ref.watch(_problemRepoProvider);
  final bmRepo = ref.watch(_bookmarkRepoProvider);
  final problems = await repo.fetchProblemsByCategory(categoryId);
  final ids = <int>{};
  for (final p in problems) {
    if (await bmRepo.isBookmarked(p.id)) {
      ids.add(p.id);
    }
  }
  return ids;
});

final completedIdsByCategoryProvider = FutureProvider.family<Set<int>, int>((
  ref,
  categoryId,
) async {
  final repo = ref.watch(_problemRepoProvider);
  final progressRepo = ref.watch(_progressRepoProvider);
  final problems = await repo.fetchProblemsByCategory(categoryId);
  final ids = <int>{};
  for (final p in problems) {
    final progress = await progressRepo.getProgress(p.id);
    if (progress.length == 3 && progress[0] && progress[1] && progress[2]) {
      ids.add(p.id);
    }
  }
  return ids;
});

// Progress counts for sorting by progress (number of completed approaches per problem)
final progressCountsByCategoryProvider =
    FutureProvider.family<Map<int, int>, int>((ref, categoryId) async {
      final repo = ref.watch(_problemRepoProvider);
      final progressRepo = ref.watch(_progressRepoProvider);
      final problems = await repo.fetchProblemsByCategory(categoryId);
      final map = <int, int>{};
      for (final p in problems) {
        final prog = await progressRepo.getProgress(p.id);
        map[p.id] = prog.where((x) => x).length;
      }
      return map;
    });

final progressByProblemProvider = FutureProvider.family<List<bool>, int>((
  ref,
  problemId,
) async {
  final progressRepo = ref.watch(_progressRepoProvider);
  return progressRepo.getProgress(problemId);
});

// Bookmark status per problem (for inline toggles)
final bookmarkByProblemProvider = FutureProvider.family<bool, int>((
  ref,
  problemId,
) async {
  final bmRepo = ref.watch(_bookmarkRepoProvider);
  return bmRepo.isBookmarked(problemId);
});

// Curated queries backed by DB flags
final neetcodeProblemsByCategoryProvider =
    FutureProvider.family<List<Problem>, int>((ref, categoryId) async {
      final repo = ref.watch(_problemRepoProvider);
      return repo.fetchNeetcode150ByCategory(categoryId);
    });

final blindProblemsByCategoryProvider =
    FutureProvider.family<List<Problem>, int>((ref, categoryId) async {
      final repo = ref.watch(_problemRepoProvider);
      return repo.fetchBlind75ByCategory(categoryId);
    });

// Base problems respecting curated selection
final visibleProblemsByCategoryProvider =
    FutureProvider.family<List<Problem>, int>((ref, categoryId) async {
      final selectedList = ref.watch(selectedListProvider);
      final repo = ref.watch(_problemRepoProvider);
      switch (selectedList) {
        case ListFilter.neetcode150:
          return repo.fetchNeetcode150ByCategory(categoryId);
        case ListFilter.blind75:
          return repo.fetchBlind75ByCategory(categoryId);
        case ListFilter.none:
          return repo.fetchProblemsByCategory(categoryId);
      }
    });

// Apply search and toggles (bookmark/completed/hide), but NOT difficulty
final preDifficultyFilteredProblemsProvider =
    FutureProvider.family<List<Problem>, int>((ref, categoryId) async {
      final base = await ref.watch(
        visibleProblemsByCategoryProvider(categoryId).future,
      );
      final bookmarkedOnly = ref.watch(bookmarkedOnlyProvider);
      final completedOnly = ref.watch(completedOnlyProvider);
      final hideCompleted = ref.watch(hideCompletedProvider);

      final bookmarkedIds = await ref.watch(
        bookmarkedIdsByCategoryProvider(categoryId).future,
      );
      final completedIds = await ref.watch(
        completedIdsByCategoryProvider(categoryId).future,
      );

      var filtered = [...base];
      if (bookmarkedOnly) {
        filtered = filtered.where((p) => bookmarkedIds.contains(p.id)).toList();
      }
      if (completedOnly) {
        filtered = filtered.where((p) => completedIds.contains(p.id)).toList();
      }
      if (hideCompleted) {
        filtered = filtered.where((p) => !completedIds.contains(p.id)).toList();
      }
      return filtered;
    });

// Apply selected difficulty on top of curated selection and toggles
final difficultyAppliedProblemsProvider =
    FutureProvider.family<List<Problem>, int>((ref, categoryId) async {
      final list = await ref
          .watch(preDifficultyFilteredProblemsProvider(categoryId).future);
      final selected = ref.watch(selectedDifficultyProvider);
      if (selected == null) return list;
      return list.where((p) => p.difficulty == selected).toList();
    });

// Counts reflecting current curated selection, search, and toggles
final difficultyCountsProvider =
    FutureProvider.family<Map<Difficulty, int>, int>((ref, categoryId) async {
      final list = await ref.watch(
        preDifficultyFilteredProblemsProvider(categoryId).future,
      );
      return {
        Difficulty.easy: list
            .where((p) => p.difficulty == Difficulty.easy)
            .length,
        Difficulty.medium: list
            .where((p) => p.difficulty == Difficulty.medium)
            .length,
        Difficulty.hard: list
            .where((p) => p.difficulty == Difficulty.hard)
            .length,
      };
    });

final curatedCountsProvider = FutureProvider.family<Map<ListFilter, int>, int>((
  ref,
  categoryId,
) async {
  final list = await ref.watch(
    preDifficultyFilteredProblemsProvider(categoryId).future,
  );
  final neetcodeCount = list.where((p) => p.isNeetcode150).length;
  final blindCount = list.where((p) => p.isBlind75).length;
  return {
    ListFilter.neetcode150: neetcodeCount,
    ListFilter.blind75: blindCount,
  };
});

class CategoryDetailScreen extends ConsumerWidget {
  const CategoryDetailScreen({super.key, required this.category});

  final Category category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Persist sort changes
    ref.listen<SortOption>(selectedSortProvider, (prev, next) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_kSortPrefKey, next.name);
    });

    // Persist filter changes
    ref.listen<Difficulty?>(selectedDifficultyProvider, (prev, next) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_kFilterDifficultyKey, next?.name ?? 'none');
    });
    ref.listen<ListFilter>(selectedListProvider, (prev, next) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_kFilterListKey, next.name);
    });
    ref.listen<bool>(bookmarkedOnlyProvider, (prev, next) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_kFilterBookmarkedOnlyKey, next);
    });
    ref.listen<bool>(completedOnlyProvider, (prev, next) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_kFilterCompletedOnlyKey, next);
    });
    ref.listen<bool>(hideCompletedProvider, (prev, next) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_kFilterHideCompletedKey, next);
    });
    ref.listen<String>(searchQueryProvider, (prev, next) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_kSearchQueryKey, next);
    });

    final selectedList = ref.watch(selectedListProvider);
    final problemsAsync = ref.watch(
      visibleProblemsByCategoryProvider(category.id),
    );
    return Scaffold(
      appBar: AppBar(title: Text(category.name)),
      body: problemsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
        data: (problems) {
          if (problems.isEmpty) {
            return const Center(child: Text('No problems available'));
          }
          final selectedList = ref.watch(selectedListProvider);
          final bookmarkedOnly = ref.watch(bookmarkedOnlyProvider);
          final completedOnly = ref.watch(completedOnlyProvider);
          final hideCompleted = ref.watch(hideCompletedProvider);
          final sortOption = ref.watch(selectedSortProvider);
          final progressCountsAsync = ref.watch(
            progressCountsByCategoryProvider(category.id),
          );
          // Base list is curated and toggle-filtered; now apply difficulty
          final filteredListAsync = ref.watch(
            difficultyAppliedProblemsProvider(category.id),
          );
          final finalList3 = filteredListAsync.asData?.value ?? problems;

          // Apply sorting
          List<Problem> sortedList = [...finalList3];
          if (sortOption != SortOption.none) {
            final progressCounts = progressCountsAsync.asData?.value;
            int rank(Difficulty d) => switch (d) {
              Difficulty.easy => 0,
              Difficulty.medium => 1,
              Difficulty.hard => 2,
            };
            int cmpDifficulty(Problem a, Problem b) =>
                rank(a.difficulty).compareTo(rank(b.difficulty));
            int cmpProgress(Problem a, Problem b) {
              final av = progressCounts?[a.id] ?? 0;
              final bv = progressCounts?[b.id] ?? 0;
              return av.compareTo(bv);
            }

            bool needProgressData =
                sortOption == SortOption.progressAsc ||
                sortOption == SortOption.progressDesc;
            if (needProgressData && progressCounts == null) {
              // defer rendering until progressCounts are loaded (spinner below)
            } else {
              switch (sortOption) {
                case SortOption.difficultyAsc:
                  sortedList.sort((a, b) => cmpDifficulty(a, b));
                  break;
                case SortOption.difficultyDesc:
                  sortedList.sort((a, b) => -cmpDifficulty(a, b));
                  break;
                case SortOption.progressAsc:
                  sortedList.sort((a, b) => cmpProgress(a, b));
                  break;
                case SortOption.progressDesc:
                  sortedList.sort((a, b) => -cmpProgress(a, b));
                  break;
                case SortOption.neetcodeFirst:
                  sortedList.sort((a, b) {
                    final ai = a.isNeetcode150 ? 0 : 1;
                    final bi = b.isNeetcode150 ? 0 : 1;
                    final pri = ai.compareTo(bi);
                    return pri != 0 ? pri : cmpDifficulty(a, b);
                  });
                  break;
                case SortOption.blindFirst:
                  sortedList.sort((a, b) {
                    final ai = a.isBlind75 ? 0 : 1;
                    final bi = b.isBlind75 ? 0 : 1;
                    final pri = ai.compareTo(bi);
                    return pri != 0 ? pri : cmpDifficulty(a, b);
                  });
                  break;
                case SortOption.none:
                  break;
              }
            }
          }

          final diffCountsAsync = ref.watch(
            difficultyCountsProvider(category.id),
          );
          final curCountsAsync = ref.watch(curatedCountsProvider(category.id));
          final easyCount =
              diffCountsAsync.asData?.value[Difficulty.easy] ??
              problems.where((p) => p.difficulty == Difficulty.easy).length;
          final mediumCount =
              diffCountsAsync.asData?.value[Difficulty.medium] ??
              problems.where((p) => p.difficulty == Difficulty.medium).length;
          final hardCount =
              diffCountsAsync.asData?.value[Difficulty.hard] ??
              problems.where((p) => p.difficulty == Difficulty.hard).length;
          final neetcodeCount =
              curCountsAsync.asData?.value[ListFilter.neetcode150] ??
              problems.where((p) => p.isNeetcode150).length;
          final blindCount =
              curCountsAsync.asData?.value[ListFilter.blind75] ??
              problems.where((p) => p.isBlind75).length;

          return Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Seed selected sort and filters from storage
                _seedSortFromStorage(ref),
                _seedFiltersFromStorage(ref),
                // Prevent overflow: allow horizontal scrolling for chip row
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _filterChip(ref, label: 'All', value: null),
                      const SizedBox(width: 8),
                      _filterChip(
                        ref,
                        label: 'Easy ($easyCount)',
                        value: Difficulty.easy,
                      ),
                      const SizedBox(width: 8),
                      _filterChip(
                        ref,
                        label: 'Medium ($mediumCount)',
                        value: Difficulty.medium,
                      ),
                      const SizedBox(width: 8),
                      _filterChip(
                        ref,
                        label: 'Hard ($hardCount)',
                        value: Difficulty.hard,
                      ),
                      const SizedBox(width: 12),
                      _listFilterChip(
                        ref,
                        label: 'Neetcode 150 ($neetcodeCount)',
                        value: ListFilter.neetcode150,
                      ),
                      const SizedBox(width: 8),
                      _listFilterChip(
                        ref,
                        label: 'Blind 75 ($blindCount)',
                        value: ListFilter.blind75,
                      ),
                      const SizedBox(width: 8),
                      _sortMenu(ref),
                      const SizedBox(width: 12),
                      FilterChip(
                        label: const Text('Bookmarked only'),
                        selected: bookmarkedOnly,
                        onSelected: (_) =>
                            ref.read(bookmarkedOnlyProvider.notifier).state =
                                !bookmarkedOnly,
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: const Text('Completed only'),
                        selected: completedOnly,
                        onSelected: (_) =>
                            ref.read(completedOnlyProvider.notifier).state =
                                !completedOnly,
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: const Text('Hide completed'),
                        selected: hideCompleted,
                        onSelected: (_) =>
                            ref.read(hideCompletedProvider.notifier).state =
                                !hideCompleted,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search problems...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (v) =>
                      ref.read(searchQueryProvider.notifier).state = v,
                ),
                const SizedBox(height: 12),
                _summaryHeader(
                  filteredCount: finalList3.length,
                  totalCount: problems.length,
                  totalMinutes: _sumMinutes(finalList3),
                ),
                const SizedBox(height: 12),
                if (((bookmarkedOnly || completedOnly || hideCompleted) &&
                        filteredListAsync.asData == null) ||
                    ((sortOption == SortOption.progressAsc ||
                            sortOption == SortOption.progressDesc) &&
                        progressCountsAsync.asData == null))
                  const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  )
                else
                  Expanded(
                    child: ListView.separated(
                      itemCount: sortedList.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final p = sortedList[index];
                        return Card(
                          child: ListTile(
                            title: Text(p.title),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_difficultyLabel(p.difficulty)),
                                const SizedBox(height: 4),
                                Consumer(
                                  builder: (context, ref, _) {
                                    final progressAsync = ref.watch(
                                      progressByProblemProvider(p.id),
                                    );
                                    return progressAsync.when(
                                      loading: () =>
                                          const LinearProgressIndicator(
                                            minHeight: 4,
                                          ),
                                      error: (e, st) => const Text(
                                        'Progress unavailable',
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                      data: (prog) {
                                        final done = prog
                                            .where((x) => x)
                                            .length;
                                        return Text(
                                          'Progress: $done/3',
                                          style: const TextStyle(
                                            color: Colors.black54,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Bookmark toggle
                                Consumer(
                                  builder: (context, ref, _) {
                                    final bmAsync = ref.watch(
                                      bookmarkByProblemProvider(p.id),
                                    );
                                    final isBm = bmAsync.asData?.value ?? false;
                                    return IconButton(
                                      tooltip: isBm
                                          ? 'Remove bookmark'
                                          : 'Add bookmark',
                                      icon: Icon(
                                        isBm
                                            ? Icons.bookmark
                                            : Icons.bookmark_border,
                                      ),
                                      onPressed: () async {
                                        final repo = ref.read(
                                          _bookmarkRepoProvider,
                                        );
                                        await repo.setBookmarked(p.id, !isBm);
                                        ref.refresh(
                                          bookmarkByProblemProvider(p.id),
                                        );
                                        ref.refresh(
                                          bookmarkedIdsByCategoryProvider(
                                            category.id,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                                const SizedBox(width: 4),
                                // Completed toggle (all three approaches)
                                Consumer(
                                  builder: (context, ref, _) {
                                    final progAsync = ref.watch(
                                      progressByProblemProvider(p.id),
                                    );
                                    final doneCount =
                                        progAsync.asData?.value
                                            .where((x) => x)
                                            .length ??
                                        0;
                                    final isComplete = doneCount == 3;
                                    return IconButton(
                                      tooltip: isComplete
                                          ? 'Mark as not completed'
                                          : 'Mark as completed',
                                      icon: Icon(
                                        isComplete
                                            ? Icons.check_circle
                                            : Icons.radio_button_unchecked,
                                        color: isComplete ? Colors.green : null,
                                      ),
                                      onPressed: () async {
                                        final repo = ref.read(
                                          _progressRepoProvider,
                                        );
                                        await repo.setProgress(
                                          p.id,
                                          isComplete
                                              ? [false, false, false]
                                              : [true, true, true],
                                        );
                                        ref.refresh(
                                          progressByProblemProvider(p.id),
                                        );
                                        ref.refresh(
                                          completedIdsByCategoryProvider(
                                            category.id,
                                          ),
                                        );
                                        ref.refresh(
                                          progressCountsByCategoryProvider(
                                            category.id,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                                const SizedBox(width: 4),
                                p.premium
                                    ? const Icon(
                                        Icons.lock,
                                        color: Colors.black45,
                                      )
                                    : const Icon(Icons.chevron_right),
                              ],
                            ),
                            onTap: () {
                              if (p.premium) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Premium problem. Upgrade to unlock.',
                                    ),
                                  ),
                                );
                                return;
                              }
                              GoRouter.of(
                                context,
                              ).go('/practice/problem/${p.id}', extra: p);
                            },
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
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

  Widget _filterChip(
    WidgetRef ref, {
    required String label,
    required Difficulty? value,
  }) {
    final selected = ref.watch(selectedDifficultyProvider);
    final isSelected = selected == value;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) =>
          ref.read(selectedDifficultyProvider.notifier).state = value,
    );
  }

  Widget _listFilterChip(
    WidgetRef ref, {
    required String label,
    required ListFilter value,
  }) {
    final selected = ref.watch(selectedListProvider);
    final isSelected = selected == value;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) {
        final current = ref.read(selectedListProvider);
        ref.read(selectedListProvider.notifier).state = current == value
            ? ListFilter.none
            : value;
      },
    );
  }

  int _sumMinutes(List<Problem> problems) =>
      problems.fold(0, (sum, p) => sum + p.estimatedMinutes);

  Widget _summaryHeader({
    required int filteredCount,
    required int totalCount,
    required int totalMinutes,
  }) {
    String timeLabel;
    if (totalMinutes >= 60) {
      final hours = (totalMinutes / 60).floor();
      final mins = totalMinutes % 60;
      timeLabel = mins == 0 ? '~$hours h' : '~$hours h $mins m';
    } else {
      timeLabel = '~$totalMinutes min';
    }
    return Row(
      children: [
        Text('Showing $filteredCount of $totalCount'),
        const Spacer(),
        Row(
          children: [
            const Icon(Icons.schedule, size: 18),
            const SizedBox(width: 6),
            Text(timeLabel),
          ],
        ),
      ],
    );
  }

  Widget _sortMenu(WidgetRef ref) {
    final selected = ref.watch(selectedSortProvider);
    String currentLabel;
    switch (selected) {
      case SortOption.none:
        currentLabel = 'Sort';
        break;
      case SortOption.difficultyAsc:
        currentLabel = 'Sort: Difficulty ↑';
        break;
      case SortOption.difficultyDesc:
        currentLabel = 'Sort: Difficulty ↓';
        break;
      case SortOption.progressAsc:
        currentLabel = 'Sort: Progress ↑';
        break;
      case SortOption.progressDesc:
        currentLabel = 'Sort: Progress ↓';
        break;
      case SortOption.neetcodeFirst:
        currentLabel = 'Sort: Neetcode first';
        break;
      case SortOption.blindFirst:
        currentLabel = 'Sort: Blind first';
        break;
    }
    return PopupMenuButton<SortOption>(
      tooltip: 'Sort problems',
      onSelected: (opt) => ref.read(selectedSortProvider.notifier).state = opt,
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: SortOption.none,
          child: Text('Default order'),
        ),
        const PopupMenuItem(
          value: SortOption.difficultyAsc,
          child: Text('Difficulty ↑'),
        ),
        const PopupMenuItem(
          value: SortOption.difficultyDesc,
          child: Text('Difficulty ↓'),
        ),
        const PopupMenuItem(
          value: SortOption.progressAsc,
          child: Text('Progress ↑ (least done first)'),
        ),
        const PopupMenuItem(
          value: SortOption.progressDesc,
          child: Text('Progress ↓ (most done first)'),
        ),
        const PopupMenuItem(
          value: SortOption.neetcodeFirst,
          child: Text('Neetcode 150 first'),
        ),
        const PopupMenuItem(
          value: SortOption.blindFirst,
          child: Text('Blind 75 first'),
        ),
      ],
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.sort),
          const SizedBox(width: 6),
          Text(currentLabel),
        ],
      ),
    );
  }

  // Seed local sort state from persisted storage
  Widget _seedSortFromStorage(WidgetRef ref) {
    () async {
      final prefs = await SharedPreferences.getInstance();
      final saved = prefs.getString(_kSortPrefKey);
      if (saved != null && saved.isNotEmpty) {
        final current = ref.read(selectedSortProvider);
        final loaded = SortOption.values.firstWhere(
          (e) => e.name == saved,
          orElse: () => SortOption.none,
        );
        if (current != loaded) {
          ref.read(selectedSortProvider.notifier).state = loaded;
        }
      }
    }();
    return const SizedBox.shrink();
  }

  // Seed filters and search from persisted storage (run once)
  Widget _seedFiltersFromStorage(WidgetRef ref) {
    if (_seededFilters) return const SizedBox.shrink();
    _seededFilters = true;
    () async {
      final prefs = await SharedPreferences.getInstance();
      final diffStr = prefs.getString(_kFilterDifficultyKey);
      if (diffStr != null) {
        Difficulty? loaded;
        if (diffStr != 'none') {
          try {
            loaded = Difficulty.values.firstWhere((d) => d.name == diffStr);
          } catch (_) {
            loaded = null;
          }
        }
        if (ref.read(selectedDifficultyProvider) != loaded) {
          ref.read(selectedDifficultyProvider.notifier).state = loaded;
        }
      }
      final listStr = prefs.getString(_kFilterListKey);
      if (listStr != null && listStr.isNotEmpty) {
        final loaded = ListFilter.values.firstWhere(
          (l) => l.name == listStr,
          orElse: () => ListFilter.none,
        );
        if (ref.read(selectedListProvider) != loaded) {
          ref.read(selectedListProvider.notifier).state = loaded;
        }
      }
      final bmOnly = prefs.getBool(_kFilterBookmarkedOnlyKey);
      if (bmOnly != null && ref.read(bookmarkedOnlyProvider) != bmOnly) {
        ref.read(bookmarkedOnlyProvider.notifier).state = bmOnly;
      }
      final compOnly = prefs.getBool(_kFilterCompletedOnlyKey);
      if (compOnly != null && ref.read(completedOnlyProvider) != compOnly) {
        ref.read(completedOnlyProvider.notifier).state = compOnly;
      }
      final hideComp = prefs.getBool(_kFilterHideCompletedKey);
      if (hideComp != null && ref.read(hideCompletedProvider) != hideComp) {
        ref.read(hideCompletedProvider.notifier).state = hideComp;
      }
      final query = prefs.getString(_kSearchQueryKey);
      if (query != null && ref.read(searchQueryProvider) != query) {
        ref.read(searchQueryProvider.notifier).state = query;
      }
    }();
    return const SizedBox.shrink();
  }
}
