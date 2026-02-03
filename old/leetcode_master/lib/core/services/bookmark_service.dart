import 'package:shared_preferences/shared_preferences.dart';

class BookmarkRepository {
  static String _keyFor(int problemId) => 'problem_bookmarked_$problemId';

  Future<bool> isBookmarked(int problemId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyFor(problemId)) ?? false;
  }

  Future<void> setBookmarked(int problemId, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyFor(problemId), value);
  }
}