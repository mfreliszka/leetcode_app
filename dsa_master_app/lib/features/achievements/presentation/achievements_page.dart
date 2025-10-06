import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../data/supabase_achievements_repository.dart';
import '../domain/models.dart';
import 'widgets/achievements_grid.dart';
import '../../../core/navigation/route_observer.dart';

class AchievementsPage extends StatefulWidget {
  const AchievementsPage({super.key});

  @override
  State<AchievementsPage> createState() => _AchievementsPageState();
}

class _AchievementsPageState extends State<AchievementsPage> with RouteAware {
  late Future<List<Achievement>> _future;
  bool _fadeIn = true;

  @override
  void initState() {
    super.initState();
    _future = const SupabaseAchievementsRepository().listAchievements();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route is PageRoute) {
      appRouteObserver.subscribe(this, route);
    }
  }

  @override
  void dispose() {
    appRouteObserver.unsubscribe(this);
    super.dispose();
  }

  // When returning to this page, refresh achievements to reflect recent awards.
  @override
  void didPopNext() {
    _refresh();
  }

  Future<void> _refresh() async {
    setState(() {
      _fadeIn = false;
      _future = const SupabaseAchievementsRepository().listAchievements();
    });
    await _future;
    if (mounted) {
      setState(() {
        _fadeIn = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    return Scaffold(
      appBar: AppBar(title: const Text('Achievements')),
      body: FutureBuilder<List<Achievement>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final achievements = snapshot.data ?? const [];
          if (achievements.isEmpty) {
            return const Center(child: Text('No achievements yet'));
          }
          return Stack(
            children: [
              RefreshIndicator(
                onRefresh: _refresh,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: AnimatedOpacity(
                    opacity: _fadeIn ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    child: AchievementsGrid(achievements: achievements),
                  ),
                ),
              ),
              if (userId == null)
                Container(
                  color: Colors.black.withOpacity(0.4),
                  child: Center(
                    child: Card(
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('Sign in to track and view your achievements'),
                            const SizedBox(height: 12),
                            ElevatedButton.icon(
                              onPressed: () => GoRouter.of(context).push('/login'),
                              icon: const Icon(Icons.login),
                              label: const Text('Sign in'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}