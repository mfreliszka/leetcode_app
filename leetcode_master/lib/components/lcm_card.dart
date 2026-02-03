import 'package:flutter/material.dart';
import '../config/constants.dart';

/// Reusable card component with LeetCode styling
class LCMCard extends StatelessWidget {
  const LCMCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.margin,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    final cardContent = Container(
      padding: padding ?? const EdgeInsets.all(LCMDimensions.paddingMD),
      margin: margin,
      decoration: BoxDecoration(
        color: LCMColors.cardBackground,
        borderRadius: BorderRadius.circular(LCMDimensions.radiusMD),
      ),
      child: child,
    );

    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(LCMDimensions.radiusMD),
          splashColor: LCMColors.primary.withOpacity(0.1),
          highlightColor: LCMColors.primary.withOpacity(0.05),
          child: cardContent,
        ),
      );
    }

    return cardContent;
  }
}
