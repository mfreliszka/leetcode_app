import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Welcome to DSA Master Home'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/explore'),
              child: const Text('Go to Explore'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => context.go('/progress'),
              child: const Text('View Progress'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => context.go('/achievements'),
              child: const Text('Achievements'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => context.go('/premium'),
              child: const Text('Go Premium'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => context.go('/profile'),
              child: const Text('Profile'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                await Supabase.instance.client.auth.signOut();
                if (!context.mounted) return;
                context.go('/');
              },
              child: const Text('Sign out'),
            ),
          ],
        ),
      ),
    );
  }
}