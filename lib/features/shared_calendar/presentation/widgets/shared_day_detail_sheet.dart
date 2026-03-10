import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/shared_day_cell.dart';
import '../../../../shared/models/calendar_event.dart';

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

  String _shiftFullName(String abbreviation) {
    switch (abbreviation) {
      case 'MD':
        return '주간';
      case 'NI':
        return '야간';
      case 'HD':
        return '휴무';
      default:
        return abbreviation;
    }
  }

  String _shiftBadgeLabel(String abbreviation) {
    switch (abbreviation) {
      case 'MD':
        return 'MD SHIFT';
      case 'NI':
        return 'NI SHIFT';
      case 'HD':
        return 'HD SHIFT';
      default:
        return '$abbreviation SHIFT';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xxl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row with title and close button
          Row(
            children: [
              Expanded(
                child: Text(
                  '$month월 $day일 ($_weekdayLabel)',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              Text(
                '오늘의 스케줄',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    size: 18,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),

          // Shift group cards
          if (summary != null && summary!.shiftCounts.isNotEmpty) ...[
            ...summary!.shiftCounts.map((sc) {
              final mockNames = _mockMemberNames(sc.abbreviation, sc.count);
              return Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.borderLight,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      // Color dot
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: sc.color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      // Title and member names
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${sc.abbreviation} ${_shiftFullName(sc.abbreviation)} (${sc.count}명)',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              mockNames.join(', '),
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Shift badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: sc.bgColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _shiftBadgeLabel(sc.abbreviation),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: sc.color,
                          ),
                        ),
                      ),
                    ],
                  ),
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

  List<String> _mockMemberNames(String abbreviation, int count) {
    const allNames = ['김철수', '이영희', '박지민', '최수진', '정하늘'];
    switch (abbreviation) {
      case 'MD':
        return allNames.sublist(0, count.clamp(0, allNames.length));
      case 'NI':
        return allNames.sublist(1, (1 + count).clamp(0, allNames.length));
      case 'HD':
        return allNames.sublist(2, (2 + count).clamp(0, allNames.length));
      default:
        return allNames.sublist(0, count.clamp(0, allNames.length));
    }
  }
}
