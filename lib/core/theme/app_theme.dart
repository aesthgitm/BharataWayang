import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.dark,
      canvasColor: AppColors.dark,
      cardColor: AppColors.surface,
      dividerColor: AppColors.accent.withValues(alpha: 0.5),
      
      colorScheme: const ColorScheme.dark(
        primary: AppColors.accent,
        secondary: AppColors.highlight,
        surface: AppColors.surface,
        onPrimary: AppColors.primary,
        onSecondary: AppColors.secondary,
        onSurface: AppColors.textPrimary,
      ),

      textTheme: TextTheme(
        displayLarge: AppTypography.headingLarge,
        displayMedium: AppTypography.headingMedium,
        displaySmall: AppTypography.headingSmall,
        bodyLarge: AppTypography.bodyLarge,
        bodyMedium: AppTypography.bodyMedium,
        bodySmall: AppTypography.bodySmall,
        labelLarge: AppTypography.buttonText,
        labelMedium: AppTypography.labelText,
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTypography.headingMedium.copyWith(color: AppColors.secondary),
        iconTheme: const IconThemeData(color: AppColors.accent),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: AppColors.primary,
          textStyle: AppTypography.buttonText,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.accent,
          side: const BorderSide(color: AppColors.accent),
          textStyle: AppTypography.buttonText.copyWith(color: AppColors.accent),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.accent, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.highlight, width: 2),
        ),
        labelStyle: AppTypography.labelText,
        hintStyle: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary.withValues(alpha: 0.5)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.primary, width: 1),
        ),
      ),
    );
  }
}
