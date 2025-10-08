import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Riverpod 3.0 legacy providers
import 'package:flutter_riverpod/legacy.dart';

import '../../core/models/problem.dart';
import '../../core/models/difficulty.dart';
import '../../app/theme.dart';
import '../../core/services/progress_service.dart';
import '../../core/services/bookmark_service.dart';
import 'package:flutter/services.dart' show Clipboard, ClipboardData;
import '../../core/repositories/problem_content_repository.dart';
import '../../core/models/problem_content.dart';
import '../../core/services/settings_service.dart';

class ProblemDetailScreen extends ConsumerWidget {
  const ProblemDetailScreen({super.key, required this.problem});

  final Problem problem;

  // Track approach progress: [bruteForce, optimized, optimal]
  static final stepsProgressProvider = StateProvider.family<List<bool>, int>((ref, problemId) => [false, false, false]);
  static final _progressRepoProvider = Provider((ref) => ApproachProgressRepository());
  static final stepsProgressLoaderProvider = FutureProvider.family<List<bool>, int>((ref, problemId) async {
    final repo = ref.watch(_progressRepoProvider);
    return repo.getProgress(problemId);
  });

  // Bookmark persistence
  static final _bookmarkRepoProvider = Provider((ref) => BookmarkRepository());
  static final bookmarkLoaderProvider = FutureProvider.family<bool, int>((ref, problemId) async {
    final repo = ref.watch(_bookmarkRepoProvider);
    return repo.isBookmarked(problemId);
  });
  static final bookmarkStateProvider = StateProvider.family<bool, int>((ref, problemId) => false);

  // Notes removed in Isar-only flow; no local notes persistence

  // Problem content (approaches) loader
  static final _contentRepoProvider = Provider((ref) => ProblemContentRepository());
  static final problemContentProvider = FutureProvider.family<ProblemContent?, int>((ref, problemId) async {
    final repo = ref.watch(_contentRepoProvider);
    return repo.fetchByProblemId(problemId);
  });

  // Default language setting is provided globally in settings_service.dart

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text(problem.title),
          actions: [
            _seedBookmarkFromStorage(ref),
            Consumer(
              builder: (context, ref, _) {
                final bookmarked = ref.watch(bookmarkStateProvider(problem.id));
                return IconButton(
                  tooltip: bookmarked ? 'Remove bookmark' : 'Bookmark',
                  icon: Icon(bookmarked ? Icons.bookmark : Icons.bookmark_outline),
                  onPressed: () async {
                    final next = !bookmarked;
                    ref.read(bookmarkStateProvider(problem.id).notifier).state = next;
                    await ref.read(_bookmarkRepoProvider).setBookmarked(problem.id, next);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(next ? 'Bookmarked' : 'Bookmark removed')),
                    );
                  },
                );
              },
            ),
            IconButton(
              tooltip: 'Copy problem link',
              icon: const Icon(Icons.share_outlined),
              onPressed: () async {
                final link = '/practice/problem/${problem.id}';
                await Clipboard.setData(ClipboardData(text: link));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Link copied: $link')),
                );
              },
            ),
            PopupMenuButton<String>(
              onSelected: (value) async {
                if (value == 'reset') {
                  await _confirmReset(context, ref);
                }
              },
              itemBuilder: (context) => const [
                PopupMenuItem<String>(
                  value: 'reset',
                  child: Text('Reset progress'),
                ),
              ],
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.description_outlined), text: 'Overview'),
              Tab(icon: Icon(Icons.code), text: 'Brute Force'),
              Tab(icon: Icon(Icons.tune), text: 'Optimized'),
              Tab(icon: Icon(Icons.auto_awesome), text: 'Optimal'),
              Tab(icon: Icon(Icons.table_chart_outlined), text: 'Summary'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _OverviewTab(),
            _BruteForceTab(),
            _OptimizedTab(),
            _OptimalTab(),
            _SummaryTab(),
          ],
        ),
      ),
    );
  }

  Widget _approachProgress(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(stepsProgressProvider(problem.id));
    final completed = progress.where((e) => e).length;
    final pct = completed / 3.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Progress: $completed/3'),
            const SizedBox(width: 12),
            Expanded(
              child: LinearProgressIndicator(value: pct, minHeight: 6),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 0,
          child: Column(
            children: [
              CheckboxListTile(
                title: const Text('Brute Force'),
                value: progress[0],
                onChanged: (v) {
                  final current = [...progress];
                  current[0] = v ?? false;
                  ref.read(stepsProgressProvider(problem.id).notifier).state = current;
                  _persist(ref, current);
                },
              ),
              const Divider(height: 0),
              CheckboxListTile(
                title: const Text('Optimized'),
                value: progress[1],
                onChanged: (v) {
                  final current = [...progress];
                  current[1] = v ?? false;
                  ref.read(stepsProgressProvider(problem.id).notifier).state = current;
                  _persist(ref, current);
                },
              ),
              const Divider(height: 0),
              CheckboxListTile(
                title: const Text('Optimal'),
                value: progress[2],
                onChanged: (v) {
                  final current = [...progress];
                  current[2] = v ?? false;
                  ref.read(stepsProgressProvider(problem.id).notifier).state = current;
                  _persist(ref, current);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Seed local state from persisted storage (runs during build; guarded to avoid loops)
  Widget _seedProgressFromStorage(WidgetRef ref) {
    final loaded = ref.watch(stepsProgressLoaderProvider(problem.id));
    loaded.whenData((value) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final current = ref.read(stepsProgressProvider(problem.id));
        final curStr = current.map((b) => b ? '1' : '0').join(',');
        final valStr = value.map((b) => b ? '1' : '0').join(',');
        if (curStr != valStr) {
          ref.read(stepsProgressProvider(problem.id).notifier).state = value;
        }
      });
    });
    return const SizedBox.shrink();
  }

  // Seed bookmark state from persisted storage
  Widget _seedBookmarkFromStorage(WidgetRef ref) {
    final loaded = ref.watch(bookmarkLoaderProvider(problem.id));
    loaded.whenData((value) {
      final current = ref.read(bookmarkStateProvider(problem.id));
      if (current != value) {
        ref.read(bookmarkStateProvider(problem.id).notifier).state = value;
      }
    });
    return const SizedBox.shrink();
  }

  Future<void> _persist(WidgetRef ref, List<bool> current) async {
    final repo = ref.read(_progressRepoProvider);
    await repo.setProgress(problem.id, current);
  }

  Widget _difficultyChip(Difficulty d) {
    Color c;
    String label;
    switch (d) {
      case Difficulty.easy:
        c = kEasyColor;
        label = 'Easy';
        break;
      case Difficulty.medium:
        c = kMediumColor;
        label = 'Medium';
        break;
      case Difficulty.hard:
        c = kHardColor;
        label = 'Hard';
        break;
    }
    return Chip(label: Text(label), backgroundColor: c.withOpacity(0.15), side: BorderSide(color: c));
  }

  Widget _timeChip(String label) {
    return Chip(
      label: Text(label),
      backgroundColor: kAccentColor.withOpacity(0.12),
      side: const BorderSide(color: kAccentColor),
    );
  }

  Future<void> _confirmReset(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Reset progress?'),
        content: const Text('This will clear approach checkboxes and remove bookmark for this problem.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Reset')),
        ],
      ),
    );
    if (confirmed == true) {
      await _resetProblemState(context, ref);
    }
  }

  Future<void> _resetProblemState(BuildContext context, WidgetRef ref) async {
    // Reset approach progress in state and storage
    final cleared = [false, false, false];
    ref.read(stepsProgressProvider(problem.id).notifier).state = cleared;
    await ref.read(_progressRepoProvider).setProgress(problem.id, cleared);

    // Reset bookmark in state and storage
    ref.read(bookmarkStateProvider(problem.id).notifier).state = false;
    await ref.read(_bookmarkRepoProvider).setBookmarked(problem.id, false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Progress reset')),
    );
  }

  // Notes and legacy steps list removed; approaches are shown per-tab

  Widget _approachCard(BuildContext context, ApproachInfo a, {String? preferredLanguage}) {
    String? usedLanguage;
    final codeToShow = () {
      if (preferredLanguage != null && a.implementations.containsKey(preferredLanguage)) {
        usedLanguage = preferredLanguage;
        return a.implementations[preferredLanguage];
      }
      if (a.implementations.isNotEmpty) {
        final firstEntry = a.implementations.entries.first;
        usedLanguage = firstEntry.key;
        return firstEntry.value;
      }
      return a.code; // no language info for this fallback
    }();
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(a.name, style: Theme.of(context).textTheme.titleMedium),
                const Spacer(),
                Chip(label: Text(a.timeComplexity)),
                const SizedBox(width: 8),
                Chip(label: Text(a.spaceComplexity)),
              ],
            ),
            const SizedBox(height: 8),
            Text(a.explanation),
            if (a.pros.isNotEmpty) ...[
              const SizedBox(height: 8),
              const Text('Pros:', style: TextStyle(fontWeight: FontWeight.w600)),
              for (final p in a.pros) Row(children: [const Text('• '), Expanded(child: Text(p))]),
            ],
            if (a.cons.isNotEmpty) ...[
              const SizedBox(height: 8),
              const Text('Cons:', style: TextStyle(fontWeight: FontWeight.w600)),
              for (final c in a.cons) Row(children: [const Text('• '), Expanded(child: Text(c))]),
            ],
            if (codeToShow != null && codeToShow.trim().isNotEmpty) ...[
              const SizedBox(height: 12),
              if (usedLanguage != null) Text('Language: $usedLanguage', style: const TextStyle(color: Colors.black54)),
              if (preferredLanguage != null && usedLanguage != null && usedLanguage != preferredLanguage)
                Text(
                  'No snippet for "$preferredLanguage"; showing "$usedLanguage"',
                  style: const TextStyle(color: Colors.black45, fontSize: 12),
                ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: const EdgeInsets.all(12),
                child: SelectableText(codeToShow, style: const TextStyle(fontFamily: 'monospace')),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Overview tab
class _OverviewTab extends ConsumerWidget {
  const _OverviewTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Access the nearest ProblemDetailScreen to read the problem
    final element = context.findAncestorWidgetOfExactType<ProblemDetailScreen>();
    final problem = element!.problem;
    final contentAsync = ref.watch(ProblemDetailScreen.problemContentProvider(problem.id));
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _difficultyChipStatic(problem.difficulty),
              const SizedBox(width: 12),
              _timeChipStatic('${problem.estimatedMinutes} min'),
              const Spacer(),
              if (problem.premium) const Icon(Icons.lock, color: Colors.black45),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: contentAsync.when(
              data: (content) {
                if (content == null) {
                  return const Center(child: Text('Content not available.'));
                }
                return ListView(
                  children: [
                    Card(
                      elevation: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Problem Statement', style: Theme.of(context).textTheme.titleMedium),
                            const SizedBox(height: 8),
                            Text(content.statement.isNotEmpty ? content.statement : 'No statement provided.'),
                          ],
                        ),
                      ),
                    ),
                    if (content.inputFormat.isNotEmpty || content.outputFormat.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Card(
                        elevation: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Input/Output', style: Theme.of(context).textTheme.titleMedium),
                              const SizedBox(height: 8),
                              if (content.inputFormat.isNotEmpty) ...[
                                const Text('Input Format', style: TextStyle(fontWeight: FontWeight.w600)),
                                const SizedBox(height: 4),
                                Text(content.inputFormat),
                              ],
                              if (content.outputFormat.isNotEmpty) ...[
                                const SizedBox(height: 8),
                                const Text('Output Format', style: TextStyle(fontWeight: FontWeight.w600)),
                                const SizedBox(height: 4),
                                Text(content.outputFormat),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ],
                    if (content.constraints.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Card(
                        elevation: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Constraints', style: Theme.of(context).textTheme.titleMedium),
                              const SizedBox(height: 8),
                              for (final c in content.constraints) ...[
                                Row(children: [
                                  const Text('• '),
                                  Expanded(child: Text(c.name.isNotEmpty ? '${c.name}: ${c.value}' : c.value)),
                                ]),
                                if (c.explanation.isNotEmpty) Padding(
                                  padding: const EdgeInsets.only(left: 18.0, top: 4),
                                  child: Text(c.explanation, style: const TextStyle(color: Colors.black54)),
                                ),
                                const SizedBox(height: 6),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ],
                    if (content.testCases.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Card(
                        elevation: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Examples', style: Theme.of(context).textTheme.titleMedium),
                              const SizedBox(height: 8),
                              for (final t in content.testCases) ...[
                                if (t.name.isNotEmpty) Text(t.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                                const SizedBox(height: 4),
                                if (t.inputJson != null && t.inputJson!.isNotEmpty)
                                  Text('Input: ${t.inputJson}'),
                                if (t.output.isNotEmpty) Text('Output: ${t.output}'),
                                if (t.explanation != null && t.explanation!.isNotEmpty)
                                  Text('Explanation: ${t.explanation}'),
                                const SizedBox(height: 12),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => const Center(child: Text('Failed to load content.')),
            ),
          ),
        ],
      ),
    );
  }

  // Static helpers for Overview tab (no instance available)
  Widget _difficultyChipStatic(Difficulty d) {
    Color c;
    String label;
    switch (d) {
      case Difficulty.easy:
        c = kEasyColor;
        label = 'Easy';
        break;
      case Difficulty.medium:
        c = kMediumColor;
        label = 'Medium';
        break;
      case Difficulty.hard:
        c = kHardColor;
        label = 'Hard';
        break;
    }
    return Chip(label: Text(label), backgroundColor: c.withOpacity(0.15), side: BorderSide(color: c));
  }

  Widget _timeChipStatic(String label) {
    return Chip(
      label: Text(label),
      backgroundColor: kAccentColor.withOpacity(0.12),
      side: const BorderSide(color: kAccentColor),
    );
  }
}

// Brute Force tab
class _BruteForceTab extends ConsumerWidget {
  const _BruteForceTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screen = context.findAncestorWidgetOfExactType<ProblemDetailScreen>()!;
    final problem = screen.problem;
    final contentAsync = ref.watch(ProblemDetailScreen.problemContentProvider(problem.id));
    final defaultLangAsync = ref.watch(defaultLanguageProvider);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              screen._difficultyChip(problem.difficulty),
              const SizedBox(width: 12),
              screen._timeChip('${problem.estimatedMinutes} min'),
              const Spacer(),
              if (problem.premium) const Icon(Icons.lock, color: Colors.black45),
            ],
          ),
          const SizedBox(height: 16),
          contentAsync.when(
            data: (content) {
              if (content == null) return const Text('Content not available.');
              final list = content.approaches.where((a) => a.key == 'brute_force').toList();
              if (list.isEmpty) return const Text('Brute Force approach not available.');
              final a = list.first;
              final selectedLang = defaultLangAsync.hasValue ? defaultLangAsync.value : null;
              return Column(children: [screen._approachCard(context, a, preferredLanguage: selectedLang)]);
            },
            loading: () => const LinearProgressIndicator(),
            error: (e, st) => const Text('Failed to load approach.'),
          ),
          const SizedBox(height: 16),
          screen._seedProgressFromStorage(ref),
          screen._approachProgress(context, ref),
        ],
      ),
    );
  }
}

// Optimized tab
class _OptimizedTab extends ConsumerWidget {
  const _OptimizedTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screen = context.findAncestorWidgetOfExactType<ProblemDetailScreen>()!;
    final problem = screen.problem;
    final contentAsync = ref.watch(ProblemDetailScreen.problemContentProvider(problem.id));
    final defaultLangAsync = ref.watch(defaultLanguageProvider);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              screen._difficultyChip(problem.difficulty),
              const SizedBox(width: 12),
              screen._timeChip('${problem.estimatedMinutes} min'),
              const Spacer(),
              if (problem.premium) const Icon(Icons.lock, color: Colors.black45),
            ],
          ),
          const SizedBox(height: 16),
          contentAsync.when(
            data: (content) {
              if (content == null) return const Text('Content not available.');
              final list = content.approaches.where((a) => a.key == 'optimized').toList();
              if (list.isEmpty) return const Text('Optimized approach not available.');
              final a = list.first;
              final selectedLang = defaultLangAsync.hasValue ? defaultLangAsync.value : null;
              return Column(children: [screen._approachCard(context, a, preferredLanguage: selectedLang)]);
            },
            loading: () => const LinearProgressIndicator(),
            error: (e, st) => const Text('Failed to load approach.'),
          ),
          const SizedBox(height: 16),
          screen._seedProgressFromStorage(ref),
          screen._approachProgress(context, ref),
        ],
      ),
    );
  }
}

// Optimal tab
class _OptimalTab extends ConsumerWidget {
  const _OptimalTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screen = context.findAncestorWidgetOfExactType<ProblemDetailScreen>()!;
    final problem = screen.problem;
    final contentAsync = ref.watch(ProblemDetailScreen.problemContentProvider(problem.id));
    final defaultLangAsync = ref.watch(defaultLanguageProvider);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              screen._difficultyChip(problem.difficulty),
              const SizedBox(width: 12),
              screen._timeChip('${problem.estimatedMinutes} min'),
              const Spacer(),
              if (problem.premium) const Icon(Icons.lock, color: Colors.black45),
            ],
          ),
          const SizedBox(height: 16),
          contentAsync.when(
            data: (content) {
              if (content == null) return const Text('Content not available.');
              final list = content.approaches.where((a) => a.key == 'optimal').toList();
              if (list.isEmpty) return const Text('Optimal approach not available.');
              final a = list.first;
              final selectedLang = defaultLangAsync.hasValue ? defaultLangAsync.value : null;
              return Column(children: [screen._approachCard(context, a, preferredLanguage: selectedLang)]);
            },
            loading: () => const LinearProgressIndicator(),
            error: (e, st) => const Text('Failed to load approach.'),
          ),
          const SizedBox(height: 16),
          screen._seedProgressFromStorage(ref),
          screen._approachProgress(context, ref),
        ],
      ),
    );
  }
}

// Summary tab
class _SummaryTab extends ConsumerWidget {
  const _SummaryTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screen = context.findAncestorWidgetOfExactType<ProblemDetailScreen>()!;
    final problem = screen.problem;
    final contentAsync = ref.watch(ProblemDetailScreen.problemContentProvider(problem.id));
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              screen._difficultyChip(problem.difficulty),
              const SizedBox(width: 12),
              screen._timeChip('${problem.estimatedMinutes} min'),
              const Spacer(),
              if (problem.premium) const Icon(Icons.lock, color: Colors.black45),
            ],
          ),
          const SizedBox(height: 16),
          contentAsync.when(
            data: (content) {
              if (content == null) return const Text('Content not available.');
              final table = content.comparisonTable;
              if (table == null || table.rows.isEmpty) {
                return const Text('Summary table coming soon.');
              }
              return Card(
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Approach Comparison', style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 12),
                      for (final r in table.rows) ...[
                        Row(children: [
                          Expanded(child: Text(r.approach, style: const TextStyle(fontWeight: FontWeight.w600))),
                          Expanded(child: Text('Time: ${r.time}')),
                          Expanded(child: Text('Space: ${r.space}')),
                        ]),
                        const SizedBox(height: 4),
                        if (r.pros.isNotEmpty) Text('Pros: ${r.pros.join(', ')}', style: const TextStyle(color: Colors.black54)),
                        if (r.cons.isNotEmpty) Text('Cons: ${r.cons.join(', ')}', style: const TextStyle(color: Colors.black54)),
                        const Divider(height: 16),
                      ],
                    ],
                  ),
                ),
              );
            },
            loading: () => const LinearProgressIndicator(),
            error: (e, st) => const Text('Failed to load summary.'),
          ),
        ],
      ),
    );
  }
}