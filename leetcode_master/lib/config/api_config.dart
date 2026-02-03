/// API configuration for the LeetCode Master app
class ApiConfig {
  ApiConfig._();

  /// Base URL for the Cloud Run API
  /// TODO: Replace with actual Cloud Run URL after deployment
  static const String baseUrl = 'https://api.leetcode-master.dev';

  /// API version prefix
  static const String apiVersion = '/v1';

  /// Full API base URL
  static String get apiBaseUrl => '$baseUrl$apiVersion';

  /// Endpoints
  static const String categoriesEndpoint = '/categories';
  static const String problemsEndpoint = '/problems';
  static const String solutionsEndpoint = '/solutions';
  static const String questionSetsEndpoint = '/question-sets';

  /// Cache configuration
  static const Duration cacheTTL = Duration(hours: 24);

  /// Timeout configuration
  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 15);
}
