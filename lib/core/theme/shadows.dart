import 'package:flutter/material.dart';
import 'colors.dart';

/// Современная система теней и эффектов
class AppShadows {
  AppShadows._();

  // Базовые тени
  static const List<BoxShadow> sm = [
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 4,
      offset: Offset(0, 2),
    ),
  ];

  static const List<BoxShadow> md = [
    BoxShadow(
      color: Color(0x14000000),
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
  ];

  static const List<BoxShadow> lg = [
    BoxShadow(
      color: Color(0x1F000000),
      blurRadius: 16,
      offset: Offset(0, 8),
    ),
  ];

  static const List<BoxShadow> xl = [
    BoxShadow(
      color: Color(0x29000000),
      blurRadius: 24,
      offset: Offset(0, 12),
    ),
  ];

  static const List<BoxShadow> xxl = [
    BoxShadow(
      color: Color(0x33000000),
      blurRadius: 40,
      offset: Offset(0, 20),
    ),
  ];

  // Многослойные тени для глубины
  static const List<BoxShadow> layered = [
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 2,
      offset: Offset(0, 1),
    ),
    BoxShadow(
      color: Color(0x14000000),
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
    BoxShadow(
      color: Color(0x1F000000),
      blurRadius: 24,
      offset: Offset(0, 12),
    ),
  ];

  // Цветные свечения (glow эффекты)
  static List<BoxShadow> primaryGlow = [
    BoxShadow(
      color: AppColors.primary.withOpacity(0.3),
      blurRadius: 20,
      spreadRadius: 0,
      offset: const Offset(0, 4),
    ),
    BoxShadow(
      color: AppColors.primary.withOpacity(0.2),
      blurRadius: 40,
      spreadRadius: 0,
      offset: const Offset(0, 8),
    ),
  ];

  static List<BoxShadow> accentGlow = [
    BoxShadow(
      color: AppColors.accent.withOpacity(0.3),
      blurRadius: 20,
      spreadRadius: 0,
      offset: const Offset(0, 4),
    ),
    BoxShadow(
      color: AppColors.accent.withOpacity(0.2),
      blurRadius: 40,
      spreadRadius: 0,
      offset: const Offset(0, 8),
    ),
  ];

  static List<BoxShadow> gradientGlow = [
    BoxShadow(
      color: AppColors.primary.withOpacity(0.2),
      blurRadius: 30,
      spreadRadius: 0,
      offset: const Offset(-10, 0),
    ),
    BoxShadow(
      color: AppColors.accent.withOpacity(0.2),
      blurRadius: 30,
      spreadRadius: 0,
      offset: const Offset(10, 0),
    ),
  ];

  // Внутренние тени (для текста и эффектов)
  static const List<Shadow> textShadow = [
    Shadow(
      color: Color(0x40000000),
      blurRadius: 8,
      offset: Offset(0, 2),
    ),
  ];

  static const List<Shadow> textGlow = [
    Shadow(
      color: AppColors.primary,
      blurRadius: 20,
      offset: Offset(0, 0),
    ),
  ];

  // Стекломорфизм (glassmorphism)
  static const List<BoxShadow> glass = [
    BoxShadow(
      color: Color(0x0DFFFFFF),
      blurRadius: 24,
      offset: Offset(0, 8),
    ),
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 16,
      offset: Offset(0, 4),
    ),
  ];

  // Тени для карточек
  static const List<BoxShadow> card = [
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
  ];

  static const List<BoxShadow> cardHover = [
    BoxShadow(
      color: Color(0x14000000),
      blurRadius: 24,
      offset: Offset(0, 12),
    ),
  ];
}