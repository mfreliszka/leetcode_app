import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    final email = user?.email ?? 'Guest';

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(radius: 28, child: Icon(Icons.person, size: 28)),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(email, style: Theme.of(context).textTheme.titleMedium),
                        Text(user != null ? 'Signed in' : 'Not signed in',
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () => context.go('/achievements'),
                  icon: const Icon(Icons.emoji_events),
                  label: const Text('View Achievements'),
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: () => context.go('/premium'),
                  icon: const Icon(Icons.workspace_premium),
                  label: const Text('Go Premium'),
                ),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: () async {
                    await Supabase.instance.client.auth.signOut();
                    if (!context.mounted) return;
                    context.go('/');
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Sign out'),
                ),
              ],
            ),
          ),
          if (user == null)
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
                        const Text('Sign in to access your profile and settings'),
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
      ),
    );
  }
}