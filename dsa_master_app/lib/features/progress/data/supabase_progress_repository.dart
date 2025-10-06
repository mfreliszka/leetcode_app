import 'package:supabase_flutter/supabase_flutter.dart';

import '../domain/models.dart';
import '../domain/progress_repository.dart';

class SupabaseProgressRepository implements ProgressRepository {
  const SupabaseProgressRepository();

  @override
  Future<ProgressMetrics> getProgress() async {
    final client = Supabase.instance.client;
    final userId = client.auth.currentUser?.id;
    if (userId == null) {
      // Not signed in; return zeros. UI overlay will prompt sign-in.
      return const ProgressMetrics(
        solvedCount: 0,
        attemptedCount: 0,
        categoriesCompleted: 0,
        currentStreakDays: 0,
        last28DaysActivity: [],
        solvedPerCategory: {},
      );
    }

    // Problems attempted via either understanding approaches or using hints.
    final aResp = await client
        .from('approach_understanding')
        .select('problem_id')
        .eq('user_id', userId)
        .eq('understood', true);
    final hResp = await client
        .from('hint_usage')
        .select('problem_id')
        .eq('user_id', userId)
        .eq('used', true);

    final attempted = <String>{};
    for (final row in (aResp as List)) {
      attempted.add((row as Map<String, dynamic>)['problem_id'].toString());
    }
    for (final row in (hResp as List)) {
      attempted.add((row as Map<String, dynamic>)['problem_id'].toString());
    }

    int solvedCount = 0;
    final solvedProblems = <String>{};
    for (final pid in attempted) {
      final totalApproachesList = await client
          .from('approaches')
          .select('id')
          .eq('problem_id', pid);
      final total = (totalApproachesList as List).length;
      if (total == 0) continue;
      final understoodList = await client
          .from('approach_understanding')
          .select('id')
          .eq('user_id', userId)
          .eq('problem_id', pid)
          .eq('understood', true);
      final understoodCount = (understoodList as List).length;
      if (understoodCount >= total) {
        solvedCount++;
        solvedProblems.add(pid);
      }
    }

    int categoriesCompleted = 0;
    final solvedPerCategory = <String, int>{};
    final solvedPerCategoryByName = <String, int>{};
    if (solvedProblems.isNotEmpty) {
      // Build solved-per-category and count distinct categories.
      final categoryIds = <String>{};
      for (final pid in solvedProblems) {
        final res = await client
            .from('problems')
            .select('category_id')
            .eq('id', pid)
            .limit(1);
        if (res is List && res.isNotEmpty) {
          final catId = (res.first as Map<String, dynamic>)['category_id'].toString();
          categoryIds.add(catId);
          solvedPerCategory.update(catId, (v) => v + 1, ifAbsent: () => 1);
        }
      }
      categoriesCompleted = categoryIds.length;

      // Resolve category names for display.
      for (final catId in categoryIds) {
        try {
          final cres = await client
              .from('categories')
              .select('name')
              .eq('id', catId)
              .limit(1);
          if (cres is List && cres.isNotEmpty) {
            final name = (cres.first as Map<String, dynamic>)['name'].toString();
            solvedPerCategoryByName[name] = solvedPerCategory[catId] ?? 0;
          }
        } catch (_) {
          // ignore name resolution failures; keep IDs-only map
        }
      }
    }

    // Activity and streak from real events (last 28 days).
    final now = DateTime.now().toUtc();
    final start = now.subtract(const Duration(days: 27));
    final acts = <DateTime>{};
    final aDates = await client
        .from('approach_understanding')
        .select('updated_at')
        .eq('user_id', userId)
        .eq('understood', true)
        .gte('updated_at', start.toIso8601String());
    final hDates = await client
        .from('hint_usage')
        .select('updated_at')
        .eq('user_id', userId)
        .eq('used', true)
        .gte('updated_at', start.toIso8601String());
    for (final row in (aDates as List)) {
      final ts = DateTime.parse((row as Map<String, dynamic>)['updated_at'].toString()).toUtc();
      acts.add(DateTime.utc(ts.year, ts.month, ts.day));
    }
    for (final row in (hDates as List)) {
      final ts = DateTime.parse((row as Map<String, dynamic>)['updated_at'].toString()).toUtc();
      acts.add(DateTime.utc(ts.year, ts.month, ts.day));
    }

    // Optional: include standalone attempt events (e.g., code runs) if available.
    try {
      final attemptDates = await client
          .from('attempts')
          .select('occurred_at')
          .eq('user_id', userId)
          .gte('occurred_at', start.toIso8601String());
      for (final row in (attemptDates as List)) {
        final ts = DateTime.parse((row as Map<String, dynamic>)['occurred_at'].toString()).toUtc();
        acts.add(DateTime.utc(ts.year, ts.month, ts.day));
      }
    } catch (_) {
      // If the table doesn't exist or RLS blocks it, ignore gracefully.
    }
    final last28 = <bool>[];
    for (int i = 27; i >= 0; i--) {
      final day = DateTime.utc(now.year, now.month, now.day).subtract(Duration(days: i));
      last28.add(acts.contains(day));
    }
    // Current streak counting from today backwards.
    int currentStreak = 0;
    for (int i = last28.length - 1; i >= 0; i--) {
      if (last28[i]) {
        currentStreak++;
      } else {
        if (i == last28.length - 1) {
          // Today has no activity; streak is zero.
          currentStreak = 0;
        }
        break;
      }
    }

    return ProgressMetrics(
      solvedCount: solvedCount,
      attemptedCount: attempted.length,
      categoriesCompleted: categoriesCompleted,
      currentStreakDays: currentStreak,
      last28DaysActivity: last28,
      solvedPerCategory: solvedPerCategory,
      solvedPerCategoryByName: solvedPerCategoryByName,
    );
  }
}