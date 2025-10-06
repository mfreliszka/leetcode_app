import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TabsShell extends StatefulWidget {
  final Widget child;
  const TabsShell({super.key, required this.child});

  @override
  State<TabsShell> createState() => _TabsShellState();
}

class _TabsShellState extends State<TabsShell> {
  int _indexFromLocation(String loc) {
    if (loc.startsWith('/explore')) return 1;
    if (loc.startsWith('/practice')) return 2;
    if (loc.startsWith('/progress')) return 3;
    if (loc.startsWith('/profile')) return 4;
    return 0; // home default
  }

  void _goToIndex(int i) {
    final router = GoRouter.of(context);
    switch (i) {
      case 0:
        router.go('/home');
        break;
      case 1:
        router.go('/explore');
        break;
      case 2:
        router.go('/practice');
        break;
      case 3:
        router.go('/progress');
        break;
      case 4:
        router.go('/profile');
        break;
      default:
        router.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = GoRouterState.of(context).matchedLocation;
    final currentIndex = _indexFromLocation(loc);
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: _goToIndex,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.explore_outlined), selectedIcon: Icon(Icons.explore), label: 'Explore'),
          NavigationDestination(icon: Icon(Icons.bolt_outlined), selectedIcon: Icon(Icons.bolt), label: 'Practice'),
          NavigationDestination(icon: Icon(Icons.bar_chart_outlined), selectedIcon: Icon(Icons.bar_chart), label: 'Progress'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}