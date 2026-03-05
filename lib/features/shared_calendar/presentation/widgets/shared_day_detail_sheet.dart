import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/shared_day_cell.dart';
import '../../../../core/widgets/shift_badge.dart';
import '../../../../shared/models/calendar_event.dart';
import '../../../../shared/models/shift_type.dart';

class SharedDayDetailSheet extends StatelessWidget {
  const SharedDayDetailSheet({
    super.key,
    required this.day,
    required this.month,
    required this.year,
    this.summary,
    this.events = const [],
  });

  final int day;
  final int month;
  final int year;
  final DayShiftSummary? summary;
  final List<CalendarEvent> events;

  String get _weekdayLabel {
    final weekday = DateTime(year, month, day).weekday;
    const labels = ['', '월', '화', '수', '목', '금', '토', '일'];
    return labels[weekday];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xxl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Center(
            child: Container(
              width: 32,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            '$month월 $day일 ($_weekdayLabel)',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          const SizedBox(height: AppSpacing.lg),

          // Shift summary
          if (summary != null && summary!.shiftCounts.isNotEmpty) ...[
            Text(
              '근무 배정',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            const SizedBox(height: AppSpacing.sm),
            ...summary!.shiftCounts.map((sc) {
              return Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: sc.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      sc.abbreviation,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: sc.color,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      '${sc.count}명',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: AppSpacing.sm),
            Text(
              '제출: ${summary!.submittedCount}/${summary!.totalMembers}명',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textTertiary,
                  ),
            ),
          ] else
            const Text(
              '배정된 근무가 없습니다',
              style: TextStyle(color: AppColors.textTertiary),
            ),

          // Events
          if (events.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.lg),
            Text(
              '이벤트',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            const SizedBox(height: AppSpacing.sm),
            ...events.map((event) {
              return Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: event.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        event.title,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }
}
