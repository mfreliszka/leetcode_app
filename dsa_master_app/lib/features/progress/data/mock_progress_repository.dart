import '../domain/models.dart';
import '../domain/progress_repository.dart';

class MockProgressRepository implements ProgressRepository {
  const MockProgressRepository();

  @override
  Future<ProgressMetrics> getProgress() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return const ProgressMetrics(
      solvedCount: 24,
      attemptedCount: 37,
      categoriesCompleted: 3,
    );
  }
}