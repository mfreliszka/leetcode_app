import 'package:supabase_flutter/supabase_flutter.dart';

import '../domain/achievements_repository.dart';
import '../domain/models.dart';

class SupabaseAchievementsRepository implements AchievementsRepository {
  const SupabaseAchievementsRepository();

  @override
  Future<List<Achievement>> listAchievements() async {
    final client = Supabase.instance.client;
    final userId = client.auth.currentUser?.id;

    final achievementsResp = await client.from('achievements').select();
    final List achievementsList = achievementsResp as List;

    Set<String> achievedIds = {};
    if (userId != null) {
      final uaResp = await client
          .from('user_achievements')
          .select('achievement_id')
          .eq('user_id', userId);
      final List uaList = uaResp as List;
      achievedIds = uaList
          .map((raw) => (raw as Map<String, dynamic>)['achievement_id'].toString())
          .toSet();
    }

    return achievementsList.map((raw) {
      final row = raw as Map<String, dynamic>;
      final id = row['id'].toString();
      return Achievement(
        id: id,
        title: row['title']?.toString() ?? '',
        description: row['description']?.toString() ?? '',
        achieved: achievedIds.contains(id),
      );
    }).toList();
  }
}