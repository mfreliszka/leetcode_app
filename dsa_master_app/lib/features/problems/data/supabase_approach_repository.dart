import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_utils.dart';

import '../domain/approach_repository.dart';
import '../domain/models.dart';

class SupabaseApproachRepository implements ApproachRepository {
  const SupabaseApproachRepository();

  @override
  Future<List<Approach>> listApproachesByProblem(String problemId) async {
    final client = Supabase.instance.client;
    final resolvedProblemId = await resolveProblemId(client, problemId);
    final resp = await client.from('approaches').select().eq('problem_id', resolvedProblemId);
    final List list = resp as List;
    return list.map((raw) {
      final row = raw as Map<String, dynamic>;
      final insights = (row['key_insights'] as List?)?.cast<String>() ?? const <String>[];
      return Approach(
        id: row['id'].toString(),
        problemId: row['problem_id'].toString(),
        type: row['type']?.toString() ?? 'unknown',
        timeComplexity: row['time_complexity']?.toString() ?? '',
        spaceComplexity: row['space_complexity']?.toString() ?? '',
        explanation: row['explanation']?.toString() ?? '',
        code: row['code']?.toString() ?? '',
        keyInsights: insights,
        language: row['language']?.toString(),
      );
    }).toList();
  }
}