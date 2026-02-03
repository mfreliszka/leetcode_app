import 'package:flutter/material.dart';
import '../../../config/constants.dart';

/// Placeholder progress screen (Phase 2)
class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(LCMDimensions.paddingLG),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: LCMColors.success.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.bar_chart,
                  size: 40,
                  color: LCMColors.success,
                ),
              ),
              const SizedBox(height: LCMDimensions.paddingLG),
              Text(
                'Coming Soon',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: LCMDimensions.paddingSM),
              const Text(
                'Track your progress with charts, heatmaps, and pattern mastery insights.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: LCMColors.textSecondary,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
