import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';

/// Service for caching API responses using Hive
class CacheService {
  CacheService._();

  static CacheService? _instance;
  static CacheService get instance => _instance ??= CacheService._();

  static const String _cacheBoxName = 'api_cache';
  Box<String>? _cacheBox;

  /// Initialize the cache service (call after Hive.initFlutter())
  Future<void> init() async {
    _cacheBox = await Hive.openBox<String>(_cacheBoxName);
  }

  /// Get cached data for a key
  /// Returns null if not cached or expired
  CachedData? get(String key) {
    final box = _cacheBox;
    if (box == null) return null;

    final raw = box.get(key);
    if (raw == null) return null;

    try {
      final decoded = jsonDecode(raw) as Map<String, dynamic>;
      final cached = CachedData.fromJson(decoded);

      // Check if expired
      if (cached.isExpired) {
        box.delete(key);
        return null;
      }

      return cached;
    } catch (_) {
      box.delete(key);
      return null;
    }
  }

  /// Store data in cache with TTL
  Future<void> put(String key, dynamic data, Duration ttl) async {
    final box = _cacheBox;
    if (box == null) return;

    final cached = CachedData(data: data, expiresAt: DateTime.now().add(ttl));

    await box.put(key, jsonEncode(cached.toJson()));
  }

  /// Clear all cached data
  Future<void> clear() async {
    await _cacheBox?.clear();
  }

  /// Clear cache for a specific key
  Future<void> delete(String key) async {
    await _cacheBox?.delete(key);
  }

  /// Clear cache for keys matching a pattern
  Future<void> deleteMatching(String pattern) async {
    final box = _cacheBox;
    if (box == null) return;

    final keysToDelete = box.keys
        .where((key) => key.toString().contains(pattern))
        .toList();

    for (final key in keysToDelete) {
      await box.delete(key);
    }
  }
}

/// Represents cached data with expiration
class CachedData {
  const CachedData({required this.data, required this.expiresAt});

  final dynamic data;
  final DateTime expiresAt;

  bool get isExpired => DateTime.now().isAfter(expiresAt);

  factory CachedData.fromJson(Map<String, dynamic> json) {
    return CachedData(
      data: json['data'],
      expiresAt: DateTime.parse(json['expiresAt'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'data': data,
    'expiresAt': expiresAt.toIso8601String(),
  };
}
