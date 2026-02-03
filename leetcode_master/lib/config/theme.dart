import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';

/// App theme configuration - Dark mode only (LeetCode style)
class LCMTheme {
  LCMTheme._();

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: LCMColors.background,
      colorScheme: const ColorScheme.dark(
        primary: LCMColors.primary,
        onPrimary: LCMColors.background,
        secondary: LCMColors.primary,
        surface: LCMColors.cardBackground,
        onSurface: LCMColors.textPrimary,
        error: LCMColors.error,
      ),

      // App Bar
      appBarTheme: AppBarTheme(
        backgroundColor: LCMColors.background,
        foregroundColor: LCMColors.textPrimary,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: LCMColors.textPrimary,
        ),
      ),

      // Bottom Navigation
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: LCMColors.cardBackground,
        selectedItemColor: LCMColors.primary,
        unselectedItemColor: LCMColors.textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // Cards
      cardTheme: CardThemeData(
        color: LCMColors.cardBackground,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(LCMDimensions.radiusMD),
        ),
      ),

      // Elevated Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: LCMColors.primary,
          foregroundColor: LCMColors.background,
          minimumSize: const Size(double.infinity, LCMDimensions.buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(LCMDimensions.radiusMD),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Text Buttons
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: LCMColors.primary,
          textStyle: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      // Outlined Buttons
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: LCMColors.textPrimary,
          minimumSize: const Size(double.infinity, LCMDimensions.buttonHeight),
          side: const BorderSide(color: LCMColors.border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(LCMDimensions.radiusMD),
          ),
        ),
      ),

      // Input Fields
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: LCMColors.cardBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(LCMDimensions.radiusMD),
          borderSide: const BorderSide(color: LCMColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(LCMDimensions.radiusMD),
          borderSide: const BorderSide(color: LCMColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(LCMDimensions.radiusMD),
          borderSide: const BorderSide(color: LCMColors.primary, width: 2),
        ),
        hintStyle: GoogleFonts.inter(color: LCMColors.textSecondary),
        labelStyle: GoogleFonts.inter(color: LCMColors.textSecondary),
      ),

      // Divider
      dividerTheme: const DividerThemeData(
        color: LCMColors.divider,
        thickness: 1,
      ),

      // Progress Indicator
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: LCMColors.primary,
        linearTrackColor: LCMColors.cardBackground,
      ),

      // Text Theme
      textTheme: TextTheme(
        displayLarge: GoogleFonts.inter(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: LCMColors.textPrimary,
        ),
        displayMedium: GoogleFonts.inter(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: LCMColors.textPrimary,
        ),
        headlineLarge: GoogleFonts.inter(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: LCMColors.textPrimary,
        ),
        headlineMedium: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: LCMColors.textPrimary,
        ),
        titleLarge: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: LCMColors.textPrimary,
        ),
        titleMedium: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: LCMColors.textPrimary,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: LCMColors.textPrimary,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: LCMColors.textPrimary,
        ),
        bodySmall: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: LCMColors.textSecondary,
        ),
        labelLarge: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: LCMColors.textPrimary,
        ),
        labelMedium: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: LCMColors.textSecondary,
        ),
      ),
    );
  }

  /// Code text style using JetBrains Mono
  static TextStyle get codeStyle => const TextStyle(
        fontFamily: 'JetBrainsMono',
        fontSize: 14,
        height: 1.5,
        color: LCMColors.textPrimary,
      );
}
