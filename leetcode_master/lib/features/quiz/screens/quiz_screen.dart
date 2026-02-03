import 'package:flutter/material.dart';
import '../../../config/constants.dart';

/// Placeholder quiz screen (Phase 2)
class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quizzes'),
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
                  color: LCMColors.primary.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.bolt,
                  size: 40,
                  color: LCMColors.primary,
                ),
              ),
              const SizedBox(height: LCMDimensions.paddingLG),
              Text(
                'Coming Soon',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: LCMDimensions.paddingSM),
              const Text(
                'Daily Challenge, Weakness Focus, and Spaced Repetition quizzes will help you reinforce your learning.',
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
