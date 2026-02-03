import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import '../config/api_config.dart';
import 'cache_service.dart';

/// Main API service using Dio with caching interceptor
class ApiService {
  ApiService._() {
    _dio = Dio(_baseOptions);
    _dio.interceptors.add(_CacheInterceptor());
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (o) => developer.log('$o', name: 'API'),
      ),
    );
  }

  static ApiService? _instance;
  static ApiService get instance => _instance ??= ApiService._();

  late final Dio _dio;

  static final BaseOptions _baseOptions = BaseOptions(
    baseUrl: ApiConfig.apiBaseUrl,
    connectTimeout: ApiConfig.connectTimeout,
    receiveTimeout: ApiConfig.receiveTimeout,
    headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
  );

  /// GET request with caching
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool useCache = true,
  }) async {
    return _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: (options ?? Options()).copyWith(extra: {'useCache': useCache}),
    );
  }

  /// POST request (no caching)
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// PUT request (no caching)
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// DELETE request (no caching)
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// Set authorization token
  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  /// Clear authorization token
  void clearAuthToken() {
    _dio.options.headers.remove('Authorization');
  }
}

/// Interceptor that handles caching for GET requests
class _CacheInterceptor extends Interceptor {
  final CacheService _cache = CacheService.instance;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Only cache GET requests
    if (options.method != 'GET') {
      handler.next(options);
      return;
    }

    // Check if caching is enabled for this request
    final useCache = options.extra['useCache'] as bool? ?? true;
    if (!useCache) {
      handler.next(options);
      return;
    }

    // Generate cache key from URL and query params
    final cacheKey = _generateCacheKey(options);
    final cached = _cache.get(cacheKey);

    if (cached != null) {
      // Return cached response
      handler.resolve(
        Response(
          requestOptions: options,
          data: cached.data,
          statusCode: 200,
          statusMessage: 'OK (cached)',
        ),
      );
      return;
    }

    // Store cache key in extras for use in onResponse
    options.extra['cacheKey'] = cacheKey;
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Cache successful GET responses
    if (response.requestOptions.method == 'GET' &&
        response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300) {
      final cacheKey = response.requestOptions.extra['cacheKey'] as String?;
      if (cacheKey != null) {
        _cache.put(cacheKey, response.data, ApiConfig.cacheTTL);
      }
    }

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // On network error, try to return cached data
    if (err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.connectionTimeout) {
      final cacheKey = _generateCacheKey(err.requestOptions);
      final cached = _cache.get(cacheKey);

      if (cached != null) {
        handler.resolve(
          Response(
            requestOptions: err.requestOptions,
            data: cached.data,
            statusCode: 200,
            statusMessage: 'OK (offline cache)',
          ),
        );
        return;
      }
    }

    handler.next(err);
  }

  String _generateCacheKey(RequestOptions options) {
    final queryString = options.queryParameters.entries
        .map((e) => '${e.key}=${e.value}')
        .join('&');
    return '${options.path}${queryString.isNotEmpty ? '?$queryString' : ''}';
  }
}
