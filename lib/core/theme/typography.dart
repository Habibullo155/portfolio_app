import 'package:flutter/material.dart';
import 'colors.dart';

/// Современная типографика с использованием системных шрифтов
class AppTypography {
  AppTypography._();

  // Базовый шрифт
  static const String fontFamily = 'SF Pro Display';

  // Display стили - для hero секций
  static const TextStyle display1 = TextStyle(
    fontSize: 72,
    fontWeight: FontWeight.w800,
    letterSpacing: -2.0,
    height: 1.1,
    color: AppColors.textPrimary,
  );

  static const TextStyle display2 = TextStyle(
    fontSize: 56,
    fontWeight: FontWeight.w700,
    letterSpacing: -1.5,
    height: 1.2,
    color: AppColors.textPrimary,
  );

  // Заголовки
  static const TextStyle h1 = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w700,
    letterSpacing: -1.0,
    height: 1.2,
    color: AppColors.textPrimary,
  );

  static const TextStyle h2 = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.5,
    height: 1.3,
    color: AppColors.textPrimary,
  );

  static const TextStyle h3 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.3,
    height: 1.3,
    color: AppColors.textPrimary,
  );

  static const TextStyle h4 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.4,
    color: AppColors.textPrimary,
  );

  static const TextStyle h5 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.4,
    color: AppColors.textPrimary,
  );

  static const TextStyle h6 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.4,
    color: AppColors.textPrimary,
  );

  // Основной текст
  static const TextStyle body1 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.6,
    color: AppColors.textSecondary,
  );

  static const TextStyle body2 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.6,
    color: AppColors.textSecondary,
  );

  static const TextStyle body3 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.5,
    color: AppColors.textSecondary,
  );

  // Специальные стили
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    height: 1.0,
    color: AppColors.textPrimary,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.3,
    height: 1.4,
    color: AppColors.textTertiary,
  );

  static const TextStyle overline = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.5,
    height: 1.4,
    color: AppColors.textTertiary,
  );

  static const TextStyle label = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    height: 1.4,
    color: AppColors.textSecondary,
  );

  // TextTheme для MaterialApp
  static const TextTheme textTheme = TextTheme(
    displayLarge: display1,
    displayMedium: display2,
    displaySmall: h1,
    headlineLarge: h2,
    headlineMedium: h3,
    headlineSmall: h4,
    titleLarge: h5,
    titleMedium: h6,
    titleSmall: body1,
    bodyLarge: body1,
    bodyMedium: body2,
    bodySmall: body3,
    labelLarge: button,
    labelMedium: caption,
    labelSmall: label,
  );
}