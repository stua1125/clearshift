import 'package:flutter/material.dart';

abstract final class AppColors {
  // Background & Surface
  static const background = Color(0xFFF7F8FA);
  static const surface = Color(0xFFFFFFFF);
  static const surfaceVariant = Color(0xFFF1F3F5);

  // Primary
  static const primary = Color(0xFF3B82F6);
  static const primaryContainer = Color(0xFFDBEAFE);
  static const onPrimary = Color(0xFFFFFFFF);

  // Text
  static const textPrimary = Color(0xFF111827);
  static const textSecondary = Color(0xFF6B7280);
  static const textTertiary = Color(0xFF9CA3AF);
  static const textOnColor = Color(0xFFFFFFFF);

  // Border
  static const border = Color(0xFFE5E7EB);
  static const borderLight = Color(0xFFF3F4F6);
  static const borderFocus = Color(0xFF3B82F6);

  // Status
  static const success = Color(0xFF10B981);
  static const warning = Color(0xFFF59E0B);
  static const error = Color(0xFFEF4444);

  // Shift Type Colors
  static const shiftDay = Color(0xFF3B82F6);
  static const shiftDayBg = Color(0xFFDBEAFE);
  static const shiftNight = Color(0xFF7C3AED);
  static const shiftNightBg = Color(0xFFEDE9FE);
  static const shiftOff = Color(0xFF10B981);
  static const shiftOffBg = Color(0xFFD1FAE5);
  static const shiftVacation = Color(0xFFF59E0B);
  static const shiftVacationBg = Color(0xFFFEF3C7);
  static const shiftTraining = Color(0xFFEC4899);
  static const shiftTrainingBg = Color(0xFFFCE7F3);

  // Calendar
  static const calendarSunday = Color(0xFFEF4444);
  static const calendarSaturday = Color(0xFF3B82F6);
  static const calendarCellHover = Color(0xFFF9FAFB);

  // Light ColorScheme
  static ColorScheme get lightColorScheme => const ColorScheme.light(
        primary: primary,
        primaryContainer: primaryContainer,
        onPrimary: onPrimary,
        surface: surface,
        onSurface: textPrimary,
        onSurfaceVariant: textSecondary,
        error: error,
        outline: border,
        outlineVariant: borderLight,
      );

  // Dark ColorScheme
  static ColorScheme get darkColorScheme => ColorScheme.dark(
        primary: primary,
        primaryContainer: const Color(0xFF1E3A5F),
        onPrimary: onPrimary,
        surface: const Color(0xFF1F2937),
        onSurface: const Color(0xFFF9FAFB),
        onSurfaceVariant: const Color(0xFF9CA3AF),
        error: error,
        outline: const Color(0xFF374151),
        outlineVariant: const Color(0xFF1F2937),
      );
}
