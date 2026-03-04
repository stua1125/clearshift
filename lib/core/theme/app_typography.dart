import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

abstract final class AppTypography {
  static String get _fontFamily => GoogleFonts.notoSansKr().fontFamily!;

  static TextTheme get textTheme => TextTheme(
        displayLarge: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 24,
          fontWeight: FontWeight.w700,
          height: 1.3,
        ),
        titleMedium: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          height: 1.4,
        ),
        titleSmall: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          height: 1.4,
        ),
        bodyMedium: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1.5,
        ),
        bodySmall: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          height: 1.5,
        ),
        labelLarge: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 12,
          fontWeight: FontWeight.w700,
          height: 1.3,
        ),
        labelSmall: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 10,
          fontWeight: FontWeight.w600,
          height: 1.3,
        ),
      );

  // Calendar specific styles
  static TextStyle get calendarDay => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get calendarDaySunday => calendarDay.copyWith(
        color: AppColors.calendarSunday,
      );

  static TextStyle get calendarDaySaturday => calendarDay.copyWith(
        color: AppColors.calendarSaturday,
      );

  static TextStyle get shiftBadge => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 9,
        fontWeight: FontWeight.w700,
      );
}
