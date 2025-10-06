import 'models.dart';

abstract class HintRepository {
  Future<List<Hint>> listHintsByProblem(String problemId);
}