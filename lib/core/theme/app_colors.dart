import 'package:flutter/material.dart';

abstract final class AppColors {
  // Background & Surface (Toss-style clean white)
  static const background = Color(0xFFFFFFFF);
  static const surface = Color(0xFFFFFFFF);
  static const surfaceVariant = Color(0xFFF4F4F5);

  // Primary (Toss Blue)
  static const primary = Color(0xFF0064FF);
  static const primaryContainer = Color(0xFFE8F0FE);
  static const onPrimary = Color(0xFFFFFFFF);

  // Text (Toss-style grayscale)
  static const textPrimary = Color(0xFF191F28);
  static const textSecondary = Color(0xFF8B95A1);
  static const textTertiary = Color(0xFFB0B8C1);
  static const textOnColor = Color(0xFFFFFFFF);

  // Border (Toss-style subtle)
  static const border = Color(0xFFE5E8EB);
  static const borderLight = Color(0xFFF2F4F6);
  static const borderFocus = Color(0xFF0064FF);

  // Status (Toss-style)
  static const success = Color(0xFF00C853);
  static const warning = Color(0xFFFF9100);
  static const error = Color(0xFFFF3B30);

  // Shift Type Colors (vibrant, TimeTree-inspired)
  static const shiftDay = Color(0xFF0064FF);
  static const shiftDayBg = Color(0xFFE8F0FE);
  static const shiftNight = Color(0xFF6C5CE7);
  static const shiftNightBg = Color(0xFFF0EDFF);
  static const shiftOff = Color(0xFF00B894);
  static const shiftOffBg = Color(0xFFE6F9F3);
  static const shiftVacation = Color(0xFFFF9100);
  static const shiftVacationBg = Color(0xFFFFF3E0);
  static const shiftTraining = Color(0xFFFF3B30);
  static const shiftTrainingBg = Color(0xFFFFEBEE);

  // Calendar
  static const calendarSunday = Color(0xFFFF3B30);
  static const calendarSaturday = Color(0xFF0064FF);
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
        primaryContainer: const Color(0xFF0A2E5C),
        onPrimary: onPrimary,
        surface: const Color(0xFF17171C),
        onSurface: const Color(0xFFF9FAFB),
        onSurfaceVariant: const Color(0xFF8B95A1),
        error: error,
        outline: const Color(0xFF2E3038),
        outlineVariant: const Color(0xFF1F2028),
      );
}
