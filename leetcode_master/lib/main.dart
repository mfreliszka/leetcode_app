import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app/router.dart';
import 'app/theme.dart';
import 'core/services/seed_service_isar.dart';
import 'core/services/settings_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await SeedService.seedIfNeeded();
  runApp(const ProviderScope(child: LeetcodeMasterApp()));
}

class LeetcodeMasterApp extends ConsumerWidget {
  const LeetcodeMasterApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Trigger loading of saved theme mode on startup
    ref.watch(themeModeLoaderProvider);
    final themeNotifier = ref.watch(themeModeNotifierProvider);
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, themeMode, _) {
        return MaterialApp.router(
          title: 'Leetcode Master',
          theme: buildAppTheme(),
          darkTheme: buildAppDarkTheme(),
          themeMode: themeMode,
          routerConfig: appRouter,
        );
      },
    );
  }
}
