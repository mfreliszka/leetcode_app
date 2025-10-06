import '../domain/achievements_repository.dart';
import '../domain/models.dart';

class MockAchievementsRepository implements AchievementsRepository {
  const MockAchievementsRepository();

  @override
  Future<List<Achievement>> listAchievements() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return const [
      Achievement(
        id: 'ach-1',
        title: 'First Solve',
        description: 'Solved your first problem',
        achieved: true,
      ),
      Achievement(
        id: 'ach-2',
        title: 'Tenacity',
        description: 'Attempted 10 problems',
        achieved: true,
      ),
      Achievement(
        id: 'ach-3',
        title: 'Consistency',
        description: 'Solved problems for 7 consecutive days',
        achieved: false,
      ),
    ];
  }
}