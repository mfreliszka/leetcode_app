import 'package:flutter/material.dart';
import '../config/constants.dart';

/// Difficulty levels for problems
enum Difficulty { easy, medium, hard }

/// Badge for displaying difficulty level
class LCMBadge extends StatelessWidget {
  const LCMBadge({
    super.key,
    required this.difficulty,
  });

  final Difficulty difficulty;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: LCMDimensions.paddingSM,
        vertical: LCMDimensions.paddingXS,
      ),
      decoration: BoxDecoration(
        color: _getColor().withOpacity(0.15),
        borderRadius: BorderRadius.circular(LCMDimensions.radiusSM),
      ),
      child: Text(
        _getLabel(),
        style: TextStyle(
          color: _getColor(),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Color _getColor() {
    switch (difficulty) {
      case Difficulty.easy:
        return LCMColors.easy;
      case Difficulty.medium:
        return LCMColors.medium;
      case Difficulty.hard:
        return LCMColors.hard;
    }
  }

  String _getLabel() {
    switch (difficulty) {
      case Difficulty.easy:
        return 'Easy';
      case Difficulty.medium:
        return 'Medium';
      case Difficulty.hard:
        return 'Hard';
    }
  }
}

/// Badge for complexity display (Time/Space)
class LCMComplexityBadge extends StatelessWidget {
  const LCMComplexityBadge({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: LCMDimensions.paddingSM,
        vertical: LCMDimensions.paddingXS,
      ),
      decoration: BoxDecoration(
        color: LCMColors.codeBackground,
        borderRadius: BorderRadius.circular(LCMDimensions.radiusSM),
        border: Border.all(color: LCMColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              color: LCMColors.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'JetBrainsMono',
              color: LCMColors.primary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

/// Premium badge indicator
class LCMPremiumBadge extends StatelessWidget {
  const LCMPremiumBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: LCMDimensions.paddingSM,
        vertical: LCMDimensions.paddingXS,
      ),
      decoration: BoxDecoration(
        color: LCMColors.primary.withOpacity(0.15),
        borderRadius: BorderRadius.circular(LCMDimensions.radiusSM),
      ),
      child: const Text(
        'Premium',
        style: TextStyle(
          color: LCMColors.primary,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
