import 'package:supabase_flutter/supabase_flutter.dart';

Future<String> resolveProblemId(SupabaseClient client, String input) async {
  final uuidRegex = RegExp(
      r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$');
  if (uuidRegex.hasMatch(input)) return input;
  final res = await client.from('problems').select('id').eq('slug', input).limit(1);
  final List list = res as List;
  if (list.isEmpty) {
    throw Exception('Problem not found for slug: $input');
  }
  final row = list.first as Map<String, dynamic>;
  return row['id'].toString();
}