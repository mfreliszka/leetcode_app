import 'package:flutter/material.dart';

class StreakCalendar extends StatelessWidget {
  final List<bool> days;
  const StreakCalendar({super.key, required this.days});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Streak Calendar', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisSpacing: 6,
                crossAxisSpacing: 6,
              ),
              itemCount: days.length,
              itemBuilder: (context, index) {
                final completed = days[index];
                return Container(
                  decoration: BoxDecoration(
                    color: completed
                        ? Theme.of(context).colorScheme.primary.withOpacity(0.85)
                        : Theme.of(context).colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(6),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}