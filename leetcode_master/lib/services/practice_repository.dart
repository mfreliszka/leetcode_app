import '../config/api_config.dart';
import '../features/practice/models/category.dart';
import '../features/practice/models/problem.dart';
import '../features/practice/models/question_set.dart';
import 'api_service.dart';

/// Repository for Practice feature API calls
class PracticeRepository {
  PracticeRepository._();

  static PracticeRepository? _instance;
  static PracticeRepository get instance =>
      _instance ??= PracticeRepository._();

  final ApiService _api = ApiService.instance;

  /// Fetch all categories
  Future<List<Category>> getCategories() async {
    final response = await _api.get<List<dynamic>>(
      ApiConfig.categoriesEndpoint,
    );

    return (response.data ?? [])
        .map((json) => Category.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  /// Fetch problems for a category
  Future<List<Problem>> getProblems(String categoryId) async {
    final response = await _api.get<List<dynamic>>(
      '${ApiConfig.problemsEndpoint}/$categoryId',
    );

    return (response.data ?? [])
        .map((json) => Problem.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  /// Fetch problem detail with approaches
  Future<ProblemDetail> getProblemDetail(String problemId) async {
    final response = await _api.get<Map<String, dynamic>>(
      '${ApiConfig.solutionsEndpoint}/$problemId',
    );

    return ProblemDetail.fromJson(response.data ?? {});
  }

  /// Fetch all question sets
  Future<List<QuestionSet>> getQuestionSets() async {
    final response = await _api.get<List<dynamic>>(
      ApiConfig.questionSetsEndpoint,
    );

    return (response.data ?? [])
        .map((json) => QuestionSet.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
