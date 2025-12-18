import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  static TextStyle get h1 => GoogleFonts.bungee(
    fontSize: 32,
    height: 1.1,
    color: AppColors.comicBlack,
  );

  static TextStyle get h2 => GoogleFonts.bungee(
    fontSize: 24,
    height: 1.2,
    color: AppColors.comicBlack,
  );

  static TextStyle get h3 => GoogleFonts.bungee(
    fontSize: 20,
    height: 1.2,
    color: AppColors.comicBlack,
  );

  static TextStyle get bodyLarge => GoogleFonts.nunito(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    height: 1.5,
    color: AppColors.midnightGrey,
  );

  static TextStyle get bodyMedium => GoogleFonts.nunito(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.5,
    color: AppColors.midnightGrey,
  );

  static TextStyle get caption => GoogleFonts.nunito(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 1.4,
    color: AppColors.midnightGrey,
  );

  static TextStyle get button => GoogleFonts.bungee(
    fontSize: 16,
    height: 1.0,
    color: AppColors.comicBlack,
  );
}
