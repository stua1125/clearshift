import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppShadows {
  static const List<BoxShadow> none = [];

  static const List<BoxShadow> sm = [
    BoxShadow(
      offset: Offset(0, 1),
      blurRadius: 2,
      color: Color(0x0D000000),
    ),
  ];

  static const List<BoxShadow> md = [
    BoxShadow(
      offset: Offset(0, 2),
      blurRadius: 8,
      color: Color(0x1A000000),
    ),
  ];

  static List<BoxShadow> focus = [
    BoxShadow(
      offset: Offset.zero,
      blurRadius: 0,
      spreadRadius: 2,
      color: AppColors.primary.withValues(alpha: 0.2),
    ),
  ];
}
