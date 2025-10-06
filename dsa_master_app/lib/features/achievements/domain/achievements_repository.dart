import 'models.dart';

abstract class AchievementsRepository {
  Future<List<Achievement>> listAchievements();
}