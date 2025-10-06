import 'models.dart';

abstract class ApproachRepository {
  Future<List<Approach>> listApproachesByProblem(String problemId);
}