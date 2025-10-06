import 'models.dart';

abstract class ProgressRepository {
  Future<ProgressMetrics> getProgress();
}

