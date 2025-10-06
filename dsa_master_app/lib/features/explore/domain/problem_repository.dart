import 'models.dart';

abstract class ProblemRepository {
  Future<List<Problem>> listProblemsByCategory(String categoryId);
}