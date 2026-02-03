import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsRepository {
  static const _defaultLangKey = 'default_language_code';
  static const _fallbackLang = 'python';

  Future<String> getDefaultLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_defaultLangKey) ?? _fallbackLang;
  }

  Future<void> setDefaultLanguage(String lang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_defaultLangKey, lang);
  }
}

// Global providers for settings
final settingsRepoProvider = Provider((ref) => SettingsRepository());
final defaultLanguageProvider = FutureProvider<String>((ref) async {
  final repo = ref.watch(settingsRepoProvider);
  return repo.getDefaultLanguage();
});