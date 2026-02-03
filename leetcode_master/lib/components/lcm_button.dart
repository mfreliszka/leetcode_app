import 'package:flutter/material.dart';
import '../config/constants.dart';

/// Different button variants
enum LCMButtonVariant { primary, secondary, ghost }

/// Reusable button component with LeetCode styling
class LCMButton extends StatelessWidget {
  const LCMButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = LCMButtonVariant.primary,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final LCMButtonVariant variant;
  final IconData? icon;
  final bool isLoading;
  final bool isFullWidth;

  @override
  Widget build(BuildContext context) {
    final buttonStyle = _getButtonStyle();

    Widget child = isLoading
        ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(LCMColors.background),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: LCMDimensions.iconMD),
                const SizedBox(width: LCMDimensions.paddingSM),
              ],
              Text(label),
            ],
          );

    Widget button;
    switch (variant) {
      case LCMButtonVariant.primary:
        button = ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: buttonStyle,
          child: child,
        );
        break;
      case LCMButtonVariant.secondary:
        button = OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: buttonStyle,
          child: child,
        );
        break;
      case LCMButtonVariant.ghost:
        button = TextButton(
          onPressed: isLoading ? null : onPressed,
          style: buttonStyle,
          child: child,
        );
        break;
    }

    if (isFullWidth) {
      return SizedBox(
        width: double.infinity,
        height: LCMDimensions.buttonHeight,
        child: button,
      );
    }

    return button;
  }

  ButtonStyle? _getButtonStyle() {
    switch (variant) {
      case LCMButtonVariant.primary:
        return ElevatedButton.styleFrom(
          backgroundColor: LCMColors.primary,
          foregroundColor: LCMColors.background,
        );
      case LCMButtonVariant.secondary:
        return OutlinedButton.styleFrom(
          foregroundColor: LCMColors.textPrimary,
          side: const BorderSide(color: LCMColors.primary),
        );
      case LCMButtonVariant.ghost:
        return TextButton.styleFrom(
          foregroundColor: LCMColors.primary,
        );
    }
  }
}
