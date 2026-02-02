import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SettingsRepository {
  static const _defaultLangKey = 'default_language_code';
  static const _fallbackLang = 'python';
  static const _themeModeKey = 'theme_mode'; // 'light' | 'dark'

  Future<String> getDefaultLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_defaultLangKey) ?? _fallbackLang;
  }

  Future<void> setDefaultLanguage(String lang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_defaultLangKey, lang);
  }

  Future<ThemeMode> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_themeModeKey);
    switch (raw) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      default:
        return ThemeMode.light;
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = mode == ThemeMode.dark ? 'dark' : 'light';
    await prefs.setString(_themeModeKey, raw);
  }
}

// Global providers for settings
final settingsRepoProvider = Provider((ref) => SettingsRepository());
final defaultLanguageProvider = FutureProvider<String>((ref) async {
  final repo = ref.watch(settingsRepoProvider);
  return repo.getDefaultLanguage();
});

// ThemeMode via ValueNotifier to avoid reliance on Riverpod-specific notifier types
final themeModeNotifierProvider = Provider<ValueNotifier<ThemeMode>>((ref) {
  final notifier = ValueNotifier<ThemeMode>(ThemeMode.light);
  ref.onDispose(notifier.dispose);
  return notifier;
});

// Loader to initialize ThemeMode from persistence at app startup
final themeModeLoaderProvider = FutureProvider<void>((ref) async {
  final repo = ref.watch(settingsRepoProvider);
  final notifier = ref.watch(themeModeNotifierProvider);
  final saved = await repo.getThemeMode();
  notifier.value = saved;
});