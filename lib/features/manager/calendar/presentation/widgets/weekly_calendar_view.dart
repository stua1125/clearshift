import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../../../core/widgets/shift_badge.dart';
import '../../providers/manager_calendar_provider.dart';

class WeeklyCalendarView extends StatelessWidget {
  const WeeklyCalendarView({
    super.key,
    required this.year,
    required this.month,
    required this.weekStartDay,
    required this.members,
    required this.onPreviousWeek,
    required this.onNextWeek,
  });

  final int year;
  final int month;
  final int weekStartDay;
  final List<TeamMember> members;
  final VoidCallback onPreviousWeek;
  final VoidCallback onNextWeek;

  List<int> get _weekDays {
    final daysInMonth = DateTime(year, month + 1, 0).day;
    return List.generate(
      7,
      (i) {
        final day = weekStartDay + i;
        return day <= daysInMonth ? day : 0;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final days = _weekDays;
    const weekdayLabels = ['월', '화', '수', '목', '금', '토', '일'];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: onPreviousWeek,
              icon: const Icon(Icons.chevron_left),
            ),
            Text(
              '$month월 $weekStartDay일~',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            IconButton(
              onPressed: onNextWeek,
              icon: const Icon(Icons.chevron_right),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 8,
            headingRowHeight: 36,
            dataRowMinHeight: 40,
            dataRowMaxHeight: 40,
            columns: [
              const DataColumn(
                label: Text('팀원', style: TextStyle(fontSize: 12)),
              ),
              ...List.generate(7, (i) {
                final day = days[i];
                final color = i == 6
                    ? AppColors.calendarSunday
                    : i == 5
                        ? AppColors.calendarSaturday
                        : AppColors.textSecondary;
                return DataColumn(
                  label: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        weekdayLabels[i],
                        style: AppTypography.calendarDay.copyWith(color: color),
                      ),
                      if (day > 0)
                        Text('$day', style: const TextStyle(fontSize: 10)),
                    ],
                  ),
                );
              }),
            ],
            rows: members.map((member) {
              return DataRow(
                cells: [
                  DataCell(
                    Text(
                      member.name,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  ...List.generate(7, (i) {
                    final day = days[i];
                    final shift = day > 0 ? member.assignments[day] : null;
                    return DataCell(
                      shift != null
                          ? ShiftBadge(
                              shiftType: shift,
                              size: ShiftBadgeSize.sm,
                            )
                          : const SizedBox.shrink(),
                    );
                  }),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
