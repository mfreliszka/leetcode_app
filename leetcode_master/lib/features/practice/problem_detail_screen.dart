import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Riverpod 3.0 legacy providers
import 'package:flutter_riverpod/legacy.dart';

import '../../core/models/problem.dart';
import '../../core/models/difficulty.dart';
import '../../app/theme.dart';
import '../../core/services/progress_service.dart';
import '../../core/services/bookmark_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart' show Clipboard, ClipboardData;
import '../../core/repositories/problem_content_repository.dart';
import '../../core/models/problem_content.dart';

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

  // Notes persistence (per-problem)
  static const String _kNotesPrefPrefix = 'problem_notes_v1_';
  static final notesLoaderProvider = FutureProvider.family<String, int>((ref, problemId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('$_kNotesPrefPrefix$problemId') ?? '';
  });
  static final notesStateProvider = StateProvider.family<String, int>((ref, problemId) => '');

  // Problem content (approaches) loader
  static final _contentRepoProvider = Provider((ref) => ProblemContentRepository());
  static final problemContentProvider = FutureProvider.family<ProblemContent?, int>((ref, problemId) async {
    final repo = ref.watch(_contentRepoProvider);
    return repo.fetchByProblemId(problemId);
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 3,
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
              Tab(icon: Icon(Icons.checklist_outlined), text: 'Steps'),
              Tab(icon: Icon(Icons.note_outlined), text: 'Notes'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _OverviewTab(),
            _StepsTab(),
            _NotesTab(),
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
      final current = ref.read(stepsProgressProvider(problem.id));
      final curStr = current.map((b) => b ? '1' : '0').join(',');
      final valStr = value.map((b) => b ? '1' : '0').join(',');
      if (curStr != valStr) {
        ref.read(stepsProgressProvider(problem.id).notifier).state = value;
      }
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

  // Seed notes from persisted storage
  Widget _seedNotesFromStorage(WidgetRef ref) {
    final loaded = ref.watch(notesLoaderProvider(problem.id));
    loaded.whenData((value) {
      final current = ref.read(notesStateProvider(problem.id));
      if (current != value) {
        ref.read(notesStateProvider(problem.id).notifier).state = value;
      }
    });
    return const SizedBox.shrink();
  }

  Future<void> _persistNotes(int id, String notes) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('$_kNotesPrefPrefix$id', notes);
  }

  // Render steps content from assets (approaches)
  Widget _stepsContent(BuildContext context, WidgetRef ref) {
    final contentAsync = ref.watch(problemContentProvider(problem.id));
    return contentAsync.when(
      data: (content) {
        if (content == null || content.approaches.isEmpty) {
          return const Text('Approach write-up coming soon.');
        }
        return Column(
          children: [
            for (final a in content.approaches) _approachCard(context, a),
          ],
        );
      },
      loading: () => const LinearProgressIndicator(),
      error: (e, st) => const Text('Failed to load approaches.'),
    );
  }

  Widget _approachCard(BuildContext context, ApproachInfo a) {
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
            if (a.code != null && a.code!.trim().isNotEmpty) ...[
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: const EdgeInsets.all(12),
                child: SelectableText(a.code!, style: const TextStyle(fontFamily: 'monospace')),
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
            child: ListView(
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
                        const Text(
                          'A clear, concise statement describing the input, required output, and constraints. This section will include edge cases and clarifications to eliminate ambiguity.',
                        ),
                      ],
                    ),
                  ),
                ),
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
                        const Text('Example 1'),
                        const SizedBox(height: 4),
                        const Text('Input: ...'),
                        const Text('Output: ...'),
                        const Text('Explanation: ...'),
                        const SizedBox(height: 12),
                        const Text('Example 2'),
                        const SizedBox(height: 4),
                        const Text('Input: ...'),
                        const Text('Output: ...'),
                        const Text('Explanation: ...'),
                      ],
                    ),
                  ),
                ),
              ],
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

// Steps tab
class _StepsTab extends ConsumerWidget {
  const _StepsTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final element = context.findAncestorWidgetOfExactType<ProblemDetailScreen>();
    final screen = element!;
    final problem = screen.problem;
    return Padding(
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
          Text('Solution roadmap', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          const Text('Brute force → Optimized → Optimal.', style: TextStyle(color: Colors.black54)),
          const SizedBox(height: 16),
          screen._stepsContent(context, ref),
          const SizedBox(height: 16),
          screen._seedProgressFromStorage(ref),
          screen._approachProgress(context, ref),
        ],
      ),
    );
  }
}

// Notes tab
class _NotesTab extends ConsumerWidget {
  const _NotesTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final element = context.findAncestorWidgetOfExactType<ProblemDetailScreen>();
    final screen = element!;
    final problem = screen.problem;

    // Seed notes from storage once
    screen._seedNotesFromStorage(ref);

    final notes = ref.watch(ProblemDetailScreen.notesStateProvider(problem.id));
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Personal notes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          const Text('Capture insights, pitfalls, and alternative approaches. Notes are saved locally.'),
          const SizedBox(height: 12),
          TextFormField(
            initialValue: notes,
            maxLines: 8,
            decoration: const InputDecoration(
              hintText: 'Write your notes here...',
              border: OutlineInputBorder(),
            ),
            onChanged: (v) async {
              ref.read(ProblemDetailScreen.notesStateProvider(problem.id).notifier).state = v;
              await screen._persistNotes(problem.id, v);
            },
          ),
        ],
      ),
    );
  }
}