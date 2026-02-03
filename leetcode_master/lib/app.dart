import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'config/theme.dart';
import 'navigation/app_router.dart';

/// Main application widget
class LeetCodeMasterApp extends ConsumerWidget {
  const LeetCodeMasterApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'LeetCode Master',
      debugShowCheckedModeBanner: false,
      theme: LCMTheme.darkTheme,
      routerConfig: appRouter,
    );
  }
}
