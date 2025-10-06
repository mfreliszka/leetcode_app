import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_utils.dart';

import '../domain/hint_repository.dart';
import '../domain/models.dart';

class SupabaseHintRepository implements HintRepository {
  const SupabaseHintRepository();

  @override
  Future<List<Hint>> listHintsByProblem(String problemId) async {
    final client = Supabase.instance.client;
    final resolvedProblemId = await resolveProblemId(client, problemId);
    final resp = await client.from('hints').select().eq('problem_id', resolvedProblemId);
    final List list = resp as List;
    return list.map((raw) {
      final row = raw as Map<String, dynamic>;
      return Hint(
        id: row['id'].toString(),
        problemId: row['problem_id'].toString(),
        text: row['text']?.toString() ?? '',
      );
    }).toList();
  }
}