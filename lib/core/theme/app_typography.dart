import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTypography {
  static const String fontFamilyBungee = 'Bungee';
  static const String fontFamilyNunito = 'Nunito';

  static TextStyle get h1 => TextStyle(
    fontFamily: fontFamilyBungee,
    fontSize: 32,
    height: 1.1,
    color: AppColors.comicBlack,
  );

  static TextStyle get h2 => TextStyle(
    fontFamily: fontFamilyBungee,
    fontSize: 24,
    height: 1.2,
    color: AppColors.comicBlack,
  );

  static TextStyle get h3 => TextStyle(
    fontFamily: fontFamilyBungee,
    fontSize: 20,
    height: 1.2,
    color: AppColors.comicBlack,
  );

  static TextStyle get bodyLarge => TextStyle(
    fontFamily: fontFamilyNunito,
    fontSize: 18,
    fontWeight: FontWeight.w700,
    height: 1.5,
    color: AppColors.midnightGrey,
  );

  static TextStyle get bodyMedium => TextStyle(
    fontFamily: fontFamilyNunito,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.5,
    color: AppColors.midnightGrey,
  );

  static TextStyle get caption => TextStyle(
    fontFamily: fontFamilyNunito,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 1.4,
    color: AppColors.midnightGrey,
  );

  static TextStyle get button => TextStyle(
    fontFamily: fontFamilyBungee,
    fontSize: 16,
    height: 1.0,
    color: AppColors.comicBlack,
  );
}
