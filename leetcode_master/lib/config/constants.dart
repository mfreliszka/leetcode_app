import 'package:flutter/material.dart';

/// LeetCode-inspired color constants for dark mode UI
class LCMColors {
  LCMColors._();

  // Backgrounds
  static const Color background = Color(0xFF282828);
  static const Color cardBackground = Color(0xFF3A3A3A);
  static const Color codeBackground = Color(0xFF1A1A1A);

  // Primary accent (LeetCode Orange)
  static const Color primary = Color(0xFFFFA116);
  static const Color primaryLight = Color(0xFFFFB84D);

  // Text colors
  static const Color textPrimary = Color(0xFFEFF2F5);
  static const Color textSecondary = Color(0xFF8C8C8C);
  static const Color textMuted = Color(0xFF5C5C5C);

  // Difficulty badges
  static const Color easy = Color(0xFF00B8A3);
  static const Color medium = Color(0xFFFFC01E);
  static const Color hard = Color(0xFFFF375F);

  // Status colors
  static const Color success = Color(0xFF2CBB5D);
  static const Color error = Color(0xFFFF375F);
  static const Color warning = Color(0xFFFFC01E);

  // Borders and dividers
  static const Color border = Color(0xFF404040);
  static const Color divider = Color(0xFF333333);
}

/// Spacing and sizing constants
class LCMDimensions {
  LCMDimensions._();

  // Padding
  static const double paddingXS = 4.0;
  static const double paddingSM = 8.0;
  static const double paddingMD = 16.0;
  static const double paddingLG = 24.0;
  static const double paddingXL = 32.0;

  // Border radius
  static const double radiusSM = 4.0;
  static const double radiusMD = 8.0;
  static const double radiusLG = 12.0;
  static const double radiusXL = 16.0;

  // Touch targets (minimum 48dp for Android)
  static const double touchTarget = 48.0;
  static const double buttonHeight = 48.0;

  // Icon sizes
  static const double iconSM = 16.0;
  static const double iconMD = 24.0;
  static const double iconLG = 32.0;
}

/// API configuration
class ApiConfig {
  ApiConfig._();

  // TODO: Replace with actual Cloud Run URL
  static const String baseUrl = 'https://api.leetcode-master.run.app';

  // Endpoints
  static const String categories = '/categories';
  static const String problems = '/problems';
  static const String solutions = '/solutions';

  // Cache TTL (24 hours in milliseconds)
  static const int cacheTtlMs = 24 * 60 * 60 * 1000;
}
