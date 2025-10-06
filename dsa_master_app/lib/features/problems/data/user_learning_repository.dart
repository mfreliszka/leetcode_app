import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_utils.dart';

class UserLearningRepository {
  const UserLearningRepository();

  SupabaseClient get _client => Supabase.instance.client;

  Future<Set<String>> getUnderstoodApproachIds(String userId, String problemId) async {
    final resolvedProblemId = await resolveProblemId(_client, problemId);
    final resp = await _client
        .from('approach_understanding')
        .select()
        .eq('user_id', userId)
        .eq('problem_id', resolvedProblemId)
        .eq('understood', true);
    final List list = resp as List;
    return list.map((raw) => (raw as Map<String, dynamic>)['approach_id'].toString()).toSet();
  }

  Future<void> markApproachUnderstood(String userId, String problemId, String approachId, bool understood) async {
    final resolvedProblemId = await resolveProblemId(_client, problemId);
    await _client.from('approach_understanding').upsert({
      'user_id': userId,
      'problem_id': resolvedProblemId,
      'approach_id': approachId,
      'understood': understood,
    });
  }

  Future<Set<String>> getUsedHintIds(String userId, String problemId) async {
    final resolvedProblemId = await resolveProblemId(_client, problemId);
    final resp = await _client
        .from('hint_usage')
        .select()
        .eq('user_id', userId)
        .eq('problem_id', resolvedProblemId)
        .eq('used', true);
    final List list = resp as List;
    return list.map((raw) => (raw as Map<String, dynamic>)['hint_id'].toString()).toSet();
  }

  Future<void> markHintUsed(String userId, String problemId, String hintId, bool used) async {
    final resolvedProblemId = await resolveProblemId(_client, problemId);
    await _client.from('hint_usage').upsert({
      'user_id': userId,
      'problem_id': resolvedProblemId,
      'hint_id': hintId,
      'used': used,
    });
  }
}