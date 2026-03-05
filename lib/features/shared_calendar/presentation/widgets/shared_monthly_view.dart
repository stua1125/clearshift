import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/shared_day_cell.dart';
import '../../../../shared/models/calendar_event.dart';

class SharedMonthlyView extends StatelessWidget {
  const SharedMonthlyView({
    super.key,
    required this.year,
    required this.month,
    required this.daySummaries,
    this.events = const [],
    this.onDayTap,
  });

  final int year;
  final int month;
  final Map<int, DayShiftSummary> daySummaries;
  final List<CalendarEvent> events;
  final ValueChanged<int>? onDayTap;

  int get _daysInMonth => DateTime(year, month + 1, 0).day;
  int get _firstWeekday => DateTime(year, month, 1).weekday % 7;

  CalendarEvent? _eventForDay(int day) {
    final date = DateTime(year, month, day);
    for (final event in events) {
      if (!date.isBefore(event.startDate) && !date.isAfter(event.endDate)) {
        return event;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isCurrentMonth = now.year == year && now.month == month;
    final totalCells = _firstWeekday + _daysInMonth;
    final rows = (totalCells / 7).ceil();

    return Column(
      children: [
        _buildWeekdayHeader(),
        const SizedBox(height: AppSpacing.cellGap),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: AppSpacing.cellGap,
            crossAxisSpacing: AppSpacing.cellGap,
            childAspectRatio: 1,
          ),
          itemCount: rows * 7,
          itemBuilder: (context, index) {
            final day = index - _firstWeekday + 1;
            if (day < 1 || day > _daysInMonth) {
              return const SizedBox.shrink();
            }

            final weekday = index % 7;
            return RepaintBoundary(
              child: SharedDayCell(
                day: day,
                summary: daySummaries[day],
                event: _eventForDay(day),
                isToday: isCurrentMonth && now.day == day,
                isSunday: weekday == 0,
                isSaturday: weekday == 6,
                onTap: () => onDayTap?.call(day),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildWeekdayHeader() {
    const weekdays = ['일', '월', '화', '수', '목', '금', '토'];
    return Row(
      children: List.generate(7, (index) {
        final color = index == 0
            ? AppColors.calendarSunday
            : index == 6
                ? AppColors.calendarSaturday
                : AppColors.textSecondary;
        return Expanded(
          child: Center(
            child: Text(
              weekdays[index],
              style: AppTypography.calendarDay.copyWith(color: color),
            ),
          ),
        );
      }),
    );
  }
}
