import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/practice/screens/category_list_screen.dart';
import '../features/practice/screens/problem_list_screen.dart';
import '../features/practice/screens/problem_workspace_screen.dart';
import '../features/quiz/screens/quiz_screen.dart';
import '../features/progress/screens/progress_screen.dart';
import '../features/settings/screens/settings_screen.dart';
import '../config/constants.dart';

/// Shell route with bottom navigation bar
class MainShell extends StatelessWidget {
  const MainShell({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        backgroundColor: LCMColors.cardBackground,
        indicatorColor: LCMColors.primary.withOpacity(0.2),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.code, color: LCMColors.textSecondary),
            selectedIcon: Icon(Icons.code, color: LCMColors.primary),
            label: 'Practice',
          ),
          NavigationDestination(
            icon: Icon(Icons.bolt_outlined, color: LCMColors.textSecondary),
            selectedIcon: Icon(Icons.bolt, color: LCMColors.primary),
            label: 'Quizzes',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined, color: LCMColors.textSecondary),
            selectedIcon: Icon(Icons.bar_chart, color: LCMColors.primary),
            label: 'Progress',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined, color: LCMColors.textSecondary),
            selectedIcon: Icon(Icons.settings, color: LCMColors.primary),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

/// App router configuration
final appRouter = GoRouter(
  initialLocation: '/practice',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainShell(navigationShell: navigationShell);
      },
      branches: [
        // Practice tab
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/practice',
              builder: (context, state) => const CategoryListScreen(),
              routes: [
                GoRoute(
                  path: 'category/:categoryId',
                  builder: (context, state) {
                    final categoryId = state.pathParameters['categoryId']!;
                    final categoryName =
                        state.uri.queryParameters['name'] ?? 'Problems';
                    return ProblemListScreen(
                      categoryId: categoryId,
                      categoryName: categoryName,
                    );
                  },
                  routes: [
                    GoRoute(
                      path: 'problem/:problemId',
                      builder: (context, state) {
                        final problemId = state.pathParameters['problemId']!;
                        return ProblemWorkspaceScreen(problemId: problemId);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        // Quiz tab
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/quiz',
              builder: (context, state) => const QuizScreen(),
            ),
          ],
        ),
        // Progress tab
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/progress',
              builder: (context, state) => const ProgressScreen(),
            ),
          ],
        ),
        // Settings tab
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) => const SettingsScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
