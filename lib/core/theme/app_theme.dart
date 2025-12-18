import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      // Colors
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.electricBlue,
        onPrimary: AppColors.pureWhite,
        secondary: AppColors.lightningYellow,
        onSecondary: AppColors.comicBlack,
        error: AppColors.vigilanteRed,
        onError: AppColors.pureWhite,
        surface: AppColors.pureWhite,
        onSurface: AppColors.midnightGrey,
        outline: AppColors.comicBlack,
      ),
      scaffoldBackgroundColor: AppColors.halftoneGrey,

      // Typography
      textTheme: TextTheme(
        displayLarge: AppTypography.h1,
        headlineMedium: AppTypography.h2,
        titleLarge: AppTypography.h3,
        bodyLarge: AppTypography.bodyLarge,
        bodyMedium: AppTypography.bodyMedium,
        labelSmall: AppTypography.caption,
        labelLarge: AppTypography.button,
      ),

      // Component Themes
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.pureWhite,
        centerTitle: true,
        titleTextStyle: AppTypography.h2,
        iconTheme: const IconThemeData(color: AppColors.comicBlack, size: 28),
        elevation: 0,
        shape: const Border(
          bottom: BorderSide(color: AppColors.comicBlack, width: 2),
        ),
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.vigilanteRed,
        foregroundColor: AppColors.pureWhite,
        elevation:
            0, // We will handle shadow manually in custom widgets usually
        shape: CircleBorder(
          side: BorderSide(color: AppColors.comicBlack, width: 2),
        ),
      ),
    );
  }
}
