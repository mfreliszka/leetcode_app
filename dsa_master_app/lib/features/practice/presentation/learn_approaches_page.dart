import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../problems/data/supabase_approach_repository.dart';
import '../../problems/data/supabase_hint_repository.dart';
import '../../problems/data/user_learning_repository.dart';
import '../../problems/domain/models.dart';
import '../../achievements/data/supabase_achievements_service.dart';

class LearnApproachesPage extends StatefulWidget {
  final String problemId;
  const LearnApproachesPage({super.key, required this.problemId});

  @override
  State<LearnApproachesPage> createState() => _LearnApproachesPageState();
}

class _LearnApproachesPageState extends State<LearnApproachesPage> {
  final _approachRepo = const SupabaseApproachRepository();
  final _hintRepo = const SupabaseHintRepository();
  final _learningRepo = const UserLearningRepository();
  final _achievementsService = const SupabaseAchievementsService();
  bool _awardNotified = false;
  void _showAchievementBanner() {
    if (!mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    messenger.removeCurrentMaterialBanner();
    messenger.showMaterialBanner(
      MaterialBanner(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        content: const Text('Achievement unlocked: Learned All Approaches'),
        leading: const Icon(Icons.emoji_events, color: Colors.amber),
        actions: [
          TextButton(
            onPressed: () {
              GoRouter.of(context).push('/achievements');
              messenger.removeCurrentMaterialBanner();
            },
            child: const Text('View'),
          ),
          TextButton(
            onPressed: () => messenger.removeCurrentMaterialBanner(),
            child: const Text('Dismiss'),
          ),
        ],
      ),
    );
  }

  late Future<_LearnData> _future;

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  Future<_LearnData> _load() async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    final approachesF = _approachRepo.listApproachesByProblem(widget.problemId);
    final hintsF = _hintRepo.listHintsByProblem(widget.problemId);
    final results = await Future.wait([approachesF, hintsF]);
    final approaches = results[0] as List<Approach>;
    final hints = results[1] as List<Hint>;

    Set<String> understood = {};
    Set<String> usedHints = {};
    if (userId != null) {
      understood = await _learningRepo.getUnderstoodApproachIds(userId, widget.problemId);
      usedHints = await _learningRepo.getUsedHintIds(userId, widget.problemId);
      // Auto-award if all approaches are already understood (covers users who completed before feature existed).
      try {
        if (approaches.isNotEmpty && understood.length >= approaches.length) {
          await _achievementsService.awardByTitle(userId, 'Learned All Approaches');
          if (mounted && !_awardNotified) {
            _awardNotified = true;
            _showAchievementBanner();
          }
        }
      } catch (_) {
        // Ignore failures silently; UI should remain responsive.
      }
    }
    return _LearnData(approaches: approaches, hints: hints, understoodApproachIds: understood, usedHintIds: usedHints);
  }

  Future<void> _toggleUnderstood(String approachId, bool next) async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sign in to track learning.')));
      return;
    }
    await _learningRepo.markApproachUnderstood(userId, widget.problemId, approachId, next);
    try {
      // After marking, check if all approaches are understood; if so, award achievement.
      final approaches = await _approachRepo.listApproachesByProblem(widget.problemId);
      final understood = await _learningRepo.getUnderstoodApproachIds(userId, widget.problemId);
      if (approaches.isNotEmpty && understood.length >= approaches.length) {
        await _achievementsService.awardByTitle(userId, 'Learned All Approaches');
        if (mounted && !_awardNotified) {
          _awardNotified = true;
          _showAchievementBanner();
        }
      }
    } catch (_) {
      // Silently ignore awarding failures to avoid disrupting UX.
    }
    setState(() {
      _future = _load();
    });
  }

  Future<void> _toggleHintUsed(String hintId, bool next) async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sign in to track hint usage.')));
      return;
    }
    await _learningRepo.markHintUsed(userId, widget.problemId, hintId, next);
    setState(() {
      _future = _load();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    return Scaffold(
      appBar: AppBar(title: Text('Learn: ${widget.problemId}')),
      body: FutureBuilder<_LearnData>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final data = snapshot.data;
          if (data == null) {
            return const Center(child: Text('No learning data'));
          }
          return Stack(
            children: [
              ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Text('Hints', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  if (data.hints.isEmpty)
                    const Text('No hints yet. Try thinking about input constraints and common patterns.')
                  else
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: data.hints
                          .map((h) => FilterChip(
                                label: Text(h.text),
                                avatar: const Icon(Icons.lightbulb_outline),
                                selected: data.usedHintIds.contains(h.id),
                                onSelected: userId == null ? null : (sel) => _toggleHintUsed(h.id, sel),
                              ))
                          .toList(),
                    ),
                  const SizedBox(height: 24),
                  Text('Approaches', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  if (data.approaches.isEmpty)
                    const Text('No approaches available yet.')
                  else
                    Column(
                      children: data.approaches
                          .map((a) => _ApproachCard(
                                approach: a,
                                understood: data.understoodApproachIds.contains(a.id),
                                onToggleUnderstood: userId == null ? (_) {} : (next) => _toggleUnderstood(a.id, next),
                              ))
                          .toList(),
                    ),
                ],
              ),
              if (userId == null)
                Container(
                  color: Colors.black.withOpacity(0.4),
                  child: Center(
                    child: Card(
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('Sign in to track learning and hints'),
                            const SizedBox(height: 12),
                            ElevatedButton.icon(
                              onPressed: () => GoRouter.of(context).push('/login'),
                              icon: const Icon(Icons.login),
                              label: const Text('Sign in'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _LearnData {
  final List<Approach> approaches;
  final List<Hint> hints;
  final Set<String> understoodApproachIds;
  final Set<String> usedHintIds;
  _LearnData({
    required this.approaches,
    required this.hints,
    required this.understoodApproachIds,
    required this.usedHintIds,
  });
}

class _ApproachCard extends StatelessWidget {
  final Approach approach;
  final bool understood;
  final ValueChanged<bool> onToggleUnderstood;
  const _ApproachCard({required this.approach, required this.understood, required this.onToggleUnderstood});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(approach.type.replaceAll('_', ' '),
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    Chip(label: Text('Time: ${approach.timeComplexity}')),
                    const SizedBox(width: 8),
                    Chip(label: Text('Space: ${approach.spaceComplexity}')),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(approach.explanation),
            if (approach.keyInsights.isNotEmpty) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children:
                    approach.keyInsights.map((k) => Chip(label: Text(k))).toList(),
              ),
            ],
            if (approach.code.isNotEmpty) ...[
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: approach.code));
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Code copied')));
                          },
                          icon: const Icon(Icons.copy),
                          label: const Text('Copy'),
                        ),
                      ],
                    ),
                    HighlightView(
                      approach.code,
                      language: approach.language ?? _detectLanguage(approach.code),
                      theme: githubTheme,
                      textStyle: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () => onToggleUnderstood(!understood),
                icon: Icon(understood ? Icons.check_circle : Icons.circle_outlined),
                label: Text(understood ? 'Understood' : 'Mark understood'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _detectLanguage(String code) {
  final lower = code.toLowerCase();
  if (lower.contains('def ') || lower.contains('# python')) return 'python';
  if (lower.contains('public ') || lower.contains('class ') || lower.contains('system.out.println')) return 'java';
  return 'dart';
}