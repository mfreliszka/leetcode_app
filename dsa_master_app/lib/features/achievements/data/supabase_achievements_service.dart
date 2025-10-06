import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAchievementsService {
  const SupabaseAchievementsService();

  Future<void> awardByTitle(String userId, String title) async {
    final client = Supabase.instance.client;
    final achResp = await client.from('achievements').select('id').eq('title', title).limit(1);
    final List list = achResp as List;
    if (list.isEmpty) return;
    final id = (list.first as Map<String, dynamic>)['id'].toString();
    await client.from('user_achievements').upsert({
      'user_id': userId,
      'achievement_id': id,
    }, onConflict: 'user_id,achievement_id');
  }
}