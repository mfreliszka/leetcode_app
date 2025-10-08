import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app/router.dart';
import 'app/theme.dart';
import 'core/services/seed_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await SeedService.seedIfNeeded();
  runApp(const ProviderScope(child: LeetcodeMasterApp()));
}

class LeetcodeMasterApp extends StatelessWidget {
  const LeetcodeMasterApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = buildAppTheme();
    return MaterialApp.router(
      title: 'Leetcode Master',
      theme: theme,
      routerConfig: appRouter,
    );
  }
}
