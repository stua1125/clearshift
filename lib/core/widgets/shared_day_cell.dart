import 'package:flutter/material.dart';

import '../../shared/models/calendar_event.dart';
import '../theme/app_colors.dart';
import '../theme/app_shadows.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

class ShiftCountData {
  const ShiftCountData({
    required this.abbreviation,
    required this.count,
    required this.color,
    required this.bgColor,
  });

  final String abbreviation;
  final int count;
  final Color color;
  final Color bgColor;
}

class DayShiftSummary {
  const DayShiftSummary({
    required this.shiftCounts,
    required this.totalMembers,
    required this.submittedCount,
  });

  final List<ShiftCountData> shiftCounts;
  final int totalMembers;
  final int submittedCount;
}

class SharedDayCell extends StatelessWidget {
  const SharedDayCell({
    super.key,
    required this.day,
    this.summary,
    this.event,
    this.isToday = false,
    this.isSunday = false,
    this.isSaturday = false,
    this.onTap,
  });

  final int day;
  final DayShiftSummary? summary;
  final CalendarEvent? event;
  final bool isToday;
  final bool isSunday;
  final bool isSaturday;
  final VoidCallback? onTap;

  Color get _dayColor {
    if (isSunday) return AppColors.calendarSunday;
    if (isSaturday) return AppColors.calendarSaturday;
    return AppColors.textPrimary;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: AppSpacing.cellHeightMobile,
        padding: const EdgeInsets.all(AppSpacing.cellPadding),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.cellBorderRadius),
          border: Border.all(
            color: isToday ? AppColors.primary : AppColors.borderLight,
            width: isToday ? 2 : 1,
          ),
          boxShadow: isToday ? AppShadows.focus : AppShadows.none,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Day number
            Text(
              '$day',
              style: AppTypography.calendarDay.copyWith(color: _dayColor),
            ),
            // Shift counts
            if (summary != null && summary!.shiftCounts.isNotEmpty)
              Expanded(
                child: Center(
                  child: Wrap(
                    spacing: 2,
                    runSpacing: 1,
                    alignment: WrapAlignment.center,
                    children: summary!.shiftCounts.map((sc) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 3,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: sc.bgColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '${sc.abbreviation}:${sc.count}',
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w700,
                            color: sc.color,
                            height: 1.2,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              )
            else
              const Spacer(),
            // Event chip
            if (event != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                decoration: BoxDecoration(
                  color: event!.color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  event!.title,
                  style: const TextStyle(fontSize: 8),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
