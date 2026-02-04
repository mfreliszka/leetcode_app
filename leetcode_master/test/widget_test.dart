// Basic Flutter widget test for LeetCode Master app.
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leetcode_master/app.dart';

void main() {
  testWidgets('App loads without errors', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: LeetCodeMasterApp()));

    // Verify that the app loads and shows Practice screen initially
    expect(find.text('Practice'), findsWidgets);
  });
}
