import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'api_service.dart';
import 'cache_service.dart';
import 'practice_repository.dart';

/// Provider for CacheService
final cacheServiceProvider = Provider<CacheService>((ref) {
  return CacheService.instance;
});

/// Provider for ApiService
final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService.instance;
});

/// Provider for PracticeRepository
final practiceRepositoryProvider = Provider<PracticeRepository>((ref) {
  return PracticeRepository.instance;
});
