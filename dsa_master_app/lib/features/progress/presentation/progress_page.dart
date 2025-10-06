import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../data/supabase_progress_repository.dart';
import '../domain/models.dart';
import 'widgets/streak_calendar.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    return Scaffold(
      appBar: AppBar(title: const Text('Progress')),
      body: FutureBuilder<ProgressMetrics>(
        future: const SupabaseProgressRepository().getProgress(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final metrics = snapshot.data;
          if (metrics == null) {
            return const Center(child: Text('No progress data'));
          }
          return Stack(
            children: [
              ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  StreakCalendar(days: metrics.last28DaysActivity.isNotEmpty ? metrics.last28DaysActivity : List<bool>.filled(28, false)),
                  const SizedBox(height: 12),
                  _MetricCard(title: 'Solved', value: metrics.solvedCount.toString()),
                  const SizedBox(height: 12),
                  _MetricCard(title: 'Attempted', value: metrics.attemptedCount.toString()),
                  const SizedBox(height: 12),
                  _MetricCard(title: 'Categories Completed', value: metrics.categoriesCompleted.toString()),
                  const SizedBox(height: 12),
                  _MetricCard(title: 'Current Streak (days)', value: metrics.currentStreakDays.toString()),
                  const SizedBox(height: 12),
                  _CategoryBreakdownCard(stats: metrics.solvedPerCategoryByName.isNotEmpty ? metrics.solvedPerCategoryByName : metrics.solvedPerCategory),
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
                            const Text('Sign in to view and track your progress'),
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

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  const _MetricCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            Text(value, style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
      ),
    );
  }
}

class _CategoryBreakdownCard extends StatelessWidget {
  final Map<String, int> stats; // key: category name or id
  const _CategoryBreakdownCard({required this.stats});

  @override
  Widget build(BuildContext context) {
    final entries = stats.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final top = entries.take(5).toList();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Top Categories Solved', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            if (top.isEmpty)
              const Text('No solved problems yet')
            else
              Column(
                children: top
                    .map((e) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: Text(e.key, overflow: TextOverflow.ellipsis)),
                              const SizedBox(width: 8),
                              Text(e.value.toString()),
                            ],
                          ),
                        ))
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }
}