import 'package:shared_preferences/shared_preferences.dart';

class ApproachProgressRepository {
  static const _keyPrefix = 'problem_steps_progress_';

  Future<List<bool>> getProgress(int problemId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_keyPrefix$problemId';
    final str = prefs.getString(key);
    if (str == null || str.isEmpty) {
      return [false, false, false];
    }
    final parts = str.split(',');
    if (parts.length != 3) {
      return [false, false, false];
    }
    return parts.map((p) => p == '1').toList();
  }

  Future<void> setProgress(int problemId, List<bool> progress) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_keyPrefix$problemId';
    final str = progress.map((b) => b ? '1' : '0').join(',');
    await prefs.setString(key, str);
  }
}