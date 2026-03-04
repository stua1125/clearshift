import 'package:flutter/material.dart';

import '../../shared/models/shift_type.dart';
import '../theme/app_shadows.dart';

enum ShiftBadgeSize { sm, md, lg }

class ShiftBadge extends StatelessWidget {
  const ShiftBadge({
    super.key,
    required this.shiftType,
    this.size = ShiftBadgeSize.md,
    this.selected = false,
  });

  final ShiftType shiftType;
  final ShiftBadgeSize size;
  final bool selected;

  double get _height => switch (size) {
        ShiftBadgeSize.sm => 18,
        ShiftBadgeSize.md => 22,
        ShiftBadgeSize.lg => 28,
      };

  double get _fontSize => switch (size) {
        ShiftBadgeSize.sm => 9,
        ShiftBadgeSize.md => 11,
        ShiftBadgeSize.lg => 13,
      };

  double get _horizontalPadding => switch (size) {
        ShiftBadgeSize.sm => 6,
        ShiftBadgeSize.md => 8,
        ShiftBadgeSize.lg => 10,
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
      decoration: BoxDecoration(
        color: shiftType.bgColor,
        borderRadius: BorderRadius.circular(_height / 2),
        border: selected
            ? Border.all(color: shiftType.color, width: 1.5)
            : null,
        boxShadow: selected
            ? [
                BoxShadow(
                  color: shiftType.color.withValues(alpha: 0.3),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ]
            : AppShadows.none,
      ),
      alignment: Alignment.center,
      child: Text(
        shiftType.abbreviation,
        style: TextStyle(
          color: shiftType.color,
          fontSize: _fontSize,
          fontWeight: FontWeight.w700,
          height: 1,
        ),
      ),
    );
  }
}
