import 'package:flutter/material.dart';

import '../../domain/models.dart';

class AchievementsGrid extends StatelessWidget {
  final List<Achievement> achievements;
  const AchievementsGrid({super.key, required this.achievements});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1.2,
      ),
      itemCount: achievements.length,
      itemBuilder: (context, index) {
        final a = achievements[index];
        return Stack(
          children: [
            Card(
              color: a.achieved
                  ? Theme.of(context).colorScheme.primaryContainer
                  : Theme.of(context).colorScheme.surface,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      a.achieved ? Icons.emoji_events : Icons.emoji_events_outlined,
                      size: 36,
                      color: a.achieved ? Colors.amber : null,
                    ),
                    const SizedBox(height: 8),
                    Text(a.title, textAlign: TextAlign.center),
                    const SizedBox(height: 4),
                    Text(
                      a.description,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Chip(
                avatar: Icon(
                  a.achieved ? Icons.check_circle : Icons.lock_outline,
                  size: 18,
                  color: a.achieved ? Colors.green : Colors.grey[700],
                ),
                label: Text(a.achieved ? 'Unlocked' : 'Locked'),
                backgroundColor: a.achieved ? Colors.green[100] : Colors.grey[200],
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
            ),
          ],
        );
      },
    );
  }
}