import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  // Cinzel - untuk semua judul dan aksen sakral
  static TextStyle get headingLarge => GoogleFonts.cinzel(
        fontSize: 32,
        fontWeight: FontWeight.w900,
        color: AppColors.accent,
      );

  static TextStyle get headingMedium => GoogleFonts.cinzel(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: AppColors.accent,
      );

  static TextStyle get headingSmall => GoogleFonts.cinzel(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: AppColors.accent,
      );

  // Inter - untuk teks konten dan UI element
  static TextStyle get bodyLarge => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
      );

  static TextStyle get bodyMedium => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
      );

  static TextStyle get bodySmall => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w300,
        color: AppColors.textPrimary,
      );

  static TextStyle get buttonText => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.primary,
      );

  static TextStyle get labelText => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
      );
}
