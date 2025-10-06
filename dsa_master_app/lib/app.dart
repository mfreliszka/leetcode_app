import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'features/auth/presentation/welcome_page.dart';
import 'features/auth/presentation/email_login_page.dart';
import 'features/home/presentation/home_page.dart';
import 'features/explore/presentation/explore_page.dart';
import 'features/explore/presentation/category_detail_page.dart';
import 'features/practice/presentation/problem_detail_page.dart';
import 'features/practice/presentation/learn_approaches_page.dart';
import 'features/practice/presentation/practice_hub_page.dart';
import 'features/progress/presentation/progress_page.dart';
import 'features/achievements/presentation/achievements_page.dart';
import 'features/subscriptions/presentation/premium_upsell_page.dart';
import 'features/profile/presentation/profile_page.dart';
import 'features/shell/presentation/tabs_shell.dart';
import 'core/navigation/route_observer.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.listen((_) {
      notifyListeners();
    });
  }
  late final StreamSubscription _subscription;
  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

class DsaMasterApp extends StatefulWidget {
  const DsaMasterApp({super.key});

  @override
  State<DsaMasterApp> createState() => _DsaMasterAppState();
}

class _DsaMasterAppState extends State<DsaMasterApp> {
  late final GoRouterRefreshStream _refresh;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    final auth = Supabase.instance.client.auth;
    _refresh = GoRouterRefreshStream(auth.onAuthStateChange);
    _router = GoRouter(
      initialLocation: '/',
      refreshListenable: _refresh,
      observers: [appRouteObserver],
      redirect: (context, state) {
        final session = auth.currentSession;
        final loc = state.matchedLocation;
        if (session != null && (loc == '/' || loc == '/login')) {
          return '/home';
        }
        if (session == null && loc == '/home') {
          return '/';
        }
        return null;
      },
      routes: [
        GoRoute(path: '/', builder: (ctx, st) => const WelcomePage()),
        GoRoute(path: '/login', builder: (ctx, st) => const EmailLoginPage()),

        ShellRoute(
          builder: (context, state, child) => TabsShell(child: child),
          routes: [
            GoRoute(path: '/home', builder: (ctx, st) => const HomePage()),
            GoRoute(path: '/explore', builder: (ctx, st) => const ExplorePage()),
            GoRoute(
              path: '/explore/:id',
              builder: (ctx, st) {
                final id = st.pathParameters['id']!;
                return CategoryDetailPage(categoryId: id);
              },
            ),
            GoRoute(path: '/practice', builder: (ctx, st) => const PracticeHubPage()),
            GoRoute(
              path: '/practice/:id',
              builder: (ctx, st) {
                final id = st.pathParameters['id']!;
                return ProblemDetailPage(problemId: id);
              },
            ),
            GoRoute(
              path: '/practice/:id/approaches',
              builder: (ctx, st) {
                final id = st.pathParameters['id']!;
                return LearnApproachesPage(problemId: id);
              },
            ),
            GoRoute(path: '/progress', builder: (ctx, st) => const ProgressPage()),
            GoRoute(
              path: '/achievements',
              builder: (ctx, st) => const AchievementsPage(),
            ),
            GoRoute(
              path: '/premium',
              builder: (ctx, st) => const PremiumUpsellPage(),
            ),
            GoRoute(
              path: '/profile',
              builder: (ctx, st) => const ProfilePage(),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _refresh.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'DSA Master',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}