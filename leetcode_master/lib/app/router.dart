import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/practice/practice_screen.dart';
import '../features/practice/category_detail_screen.dart';
import '../features/practice/problem_detail_screen.dart';
import '../features/practice/bookmarks_screen.dart';
import '../features/quizzes/quizzes_screen.dart';
import '../features/progress/progress_screen.dart';
import '../features/settings/settings_screen.dart';
import '../core/models/category.dart';
import '../core/models/problem.dart';
import '../core/repositories/category_repository_isar.dart';
import '../core/repositories/problem_repository_isar.dart';

final appRouter = GoRouter(
  initialLocation: '/practice',
  routes: [
    ShellRoute(
      builder: (context, state, child) => HomeShell(child: child),
      routes: [
        GoRoute(
          path: '/practice',
          name: 'practice',
          builder: (context, state) => const PracticeScreen(),
        ),
        GoRoute(
          path: '/practice/bookmarks',
          name: 'bookmarks',
          builder: (context, state) => const BookmarksScreen(),
        ),
        GoRoute(
          path: '/practice/category/:id',
          name: 'category_detail',
          builder: (context, state) {
            final extra = state.extra;
            if (extra is Category) {
              return CategoryDetailScreen(category: extra);
            }
            final idStr = state.pathParameters['id'];
            final id = int.tryParse(idStr ?? '');
            if (id == null) {
              return const Scaffold(
                body: Center(child: Text('Category not found')),
              );
            }
            return CategoryDetailRoute(categoryId: id);
          },
        ),
        GoRoute(
          path: '/practice/problem/:id',
          name: 'problem_detail',
          builder: (context, state) {
            final extra = state.extra;
            if (extra is Problem) {
              return ProblemDetailScreen(problem: extra);
            }
            final idStr = state.pathParameters['id'];
            final id = int.tryParse(idStr ?? '');
            if (id == null) {
              return const Scaffold(
                body: Center(child: Text('Problem not found')),
              );
            }
            return ProblemDetailRoute(problemId: id);
          },
        ),
        GoRoute(
          path: '/quizzes',
          name: 'quizzes',
          builder: (context, state) => const QuizzesScreen(),
        ),
        GoRoute(
          path: '/progress',
          name: 'progress',
          builder: (context, state) => const ProgressScreen(),
        ),
        GoRoute(
          path: '/settings',
          name: 'settings',
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    ),
  ],
);

class HomeShell extends StatefulWidget {
  const HomeShell({super.key, required this.child});
  final Widget child;

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class ProblemDetailRoute extends StatelessWidget {
  const ProblemDetailRoute({super.key, required this.problemId});

  final int problemId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Problem?>(
      future: ProblemRepository().findById(problemId),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final problem = snapshot.data;
        if (problem == null) {
          return const Scaffold(body: Center(child: Text('Problem not found')));
        }
        return ProblemDetailScreen(problem: problem);
      },
    );
  }
}

class CategoryDetailRoute extends StatelessWidget {
  const CategoryDetailRoute({super.key, required this.categoryId});

  final int categoryId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Category?>(
      future: CategoryRepository().findById(categoryId),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final category = snapshot.data;
        if (category == null) {
          return const Scaffold(
            body: Center(child: Text('Category not found')),
          );
        }
        return CategoryDetailScreen(category: category);
      },
    );
  }
}

class _HomeShellState extends State<HomeShell> {
  int _currentIndexFromLocation(String location) {
    if (location.startsWith('/quizzes')) return 1;
    if (location.startsWith('/progress')) return 2;
    if (location.startsWith('/settings')) return 3;
    return 0; // practice
  }

  void _onTap(int index) {
    switch (index) {
      case 0:
        context.go('/practice');
        break;
      case 1:
        context.go('/quizzes');
        break;
      case 2:
        context.go('/progress');
        break;
      case 3:
        context.go('/settings');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = _currentIndexFromLocation(location);
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: _onTap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Practice',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flash_on_outlined),
            activeIcon: Icon(Icons.flash_on),
            label: 'Quizzes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            activeIcon: Icon(Icons.bar_chart),
            label: 'Progress',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
