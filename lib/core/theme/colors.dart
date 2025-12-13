import 'package:flutter/material.dart';

/// Современная цветовая палитра для портфолио
class AppColors {
  AppColors._();

  // Основные цвета
  static const Color background = Color(0xFF0A0A0A);
  static const Color surface = Color(0xFF151515);
  static const Color surfaceLight = Color(0xFF1E1E1E);
  
  // Акцентные цвета - современный градиент
  static const Color primary = Color(0xFF6366F1); // Indigo
  static const Color primaryLight = Color(0xFF818CF8);
  static const Color accent = Color(0xFFA855F7); // Purple
  static const Color accentLight = Color(0xFFC084FC);
  
  // Дополнительные акценты
  static const Color cyan = Color(0xFF06B6D4);
  static const Color pink = Color(0xFFEC4899);
  static const Color emerald = Color(0xFF10B981);
  
  // Текстовые цвета
  static const Color textPrimary = Color(0xFFFAFAFA);
  static const Color textSecondary = Color(0xFFA1A1AA);
  static const Color textTertiary = Color(0xFF71717A);
  
  // Градиенты
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, accent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient heroGradient = LinearGradient(
    colors: [primary, accent, pink],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient glassGradient = LinearGradient(
    colors: [
      Color(0x1AFFFFFF),
      Color(0x0DFFFFFF),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // Эффекты
  static const Color glow = Color(0x4D6366F1);
  static const Color glowAccent = Color(0x4DA855F7);
  
  // Статусные цвета
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);
}