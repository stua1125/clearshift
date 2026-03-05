import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/shift_badge.dart';
import '../../../../shared/models/calendar_event.dart';
import '../../../../shared/models/shift_type.dart';
import '../providers/shared_calendar_provider.dart';

class SharedWeeklyView extends StatelessWidget {
  const SharedWeeklyView({
    super.key,
    required this.year,
    required this.month,
    required this.weekStartDay,
    required this.members,
    this.events = const [],
    this.onWeekChange,
  });

  final int year;
  final int month;
  final int weekStartDay;
  final List<MemberWeekRow> members;
  final List<CalendarEvent> events;
  final ValueChanged<int>? onWeekChange;

  int get _daysInMonth => DateTime(year, month + 1, 0).day;

  List<int> get _weekDays {
    final days = <int>[];
    for (int i = 0; i < 7; i++) {
      final day = weekStartDay + i;
      if (day <= _daysInMonth) days.add(day);
    }
    return days;
  }

  int get _prevWeekStart {
    final prev = weekStartDay - 7;
    return prev >= 1 ? prev : 1;
  }

  int get _nextWeekStart {
    final next = weekStartDay + 7;
    return next <= _daysInMonth ? next : weekStartDay;
  }

  bool get _canGoPrev => weekStartDay > 1;
  bool get _canGoNext => weekStartDay + 7 <= _daysInMonth;

  String get _weekLabel {
    final weekNum = ((weekStartDay - 1) / 7).floor() + 1;
    return '$month월 ${weekNum}주차 ($weekStartDay~${_weekDays.last}일)';
  }

  @override
  Widget build(BuildContext context) {
    final weekDays = _weekDays;
    final now = DateTime.now();
    final isCurrentMonth = now.year == year && now.month == month;

    return Column(
      children: [
        // Week navigator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: _canGoPrev ? () => onWeekChange?.call(_prevWeekStart) : null,
              icon: const Icon(Icons.chevron_left),
              iconSize: 24,
            ),
            Text(
              _weekLabel,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            IconButton(
              onPressed: _canGoNext ? () => onWeekChange?.call(_nextWeekStart) : null,
              icon: const Icon(Icons.chevron_right),
              iconSize: 24,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        // Grid
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 4,
            horizontalMargin: 8,
            headingRowHeight: 36,
            dataRowMinHeight: 36,
            dataRowMaxHeight: 40,
            columns: [
              const DataColumn(
                label: SizedBox(
                  width: 60,
                  child: Text('이름', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                ),
              ),
              ...weekDays.map((day) {
                final weekday = DateTime(year, month, day).weekday;
                final dayLabel = ['', '월', '화', '수', '목', '금', '토', '일'][weekday];
                final isToday = isCurrentMonth && now.day == day;
                final isSunday = weekday == 7;
                final isSaturday = weekday == 6;

                return DataColumn(
                  label: SizedBox(
                    width: 40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          dayLabel,
                          style: TextStyle(
                            fontSize: 10,
                            color: isSunday
                                ? AppColors.calendarSunday
                                : isSaturday
                                    ? AppColors.calendarSaturday
                                    : AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          '$day',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isToday ? FontWeight.w700 : FontWeight.w500,
                            color: isToday
                                ? AppColors.primary
                                : isSunday
                                    ? AppColors.calendarSunday
                                    : isSaturday
                                        ? AppColors.calendarSaturday
                                        : AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
            rows: members.map((member) {
              return DataRow(
                cells: [
                  DataCell(
                    SizedBox(
                      width: 60,
                      child: Text(
                        member.userName,
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  ...weekDays.map((day) {
                    final shift = member.assignments[day];
                    return DataCell(
                      SizedBox(
                        width: 40,
                        child: Center(
                          child: shift != null
                              ? ShiftBadge(shiftType: shift, size: ShiftBadgeSize.sm)
                              : const Text('-', style: TextStyle(fontSize: 10, color: AppColors.textTertiary)),
                        ),
                      ),
                    );
                  }),
                ],
              );
            }).toList(),
          ),
        ),
        // Events bar
        if (events.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.md),
          ...events.where((e) {
            final start = DateTime(year, month, weekStartDay);
            final end = DateTime(year, month, _weekDays.last);
            return !e.endDate.isBefore(start) && !e.startDate.isAfter(end);
          }).map((event) {
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xs),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: event.color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(4),
                  border: Border(left: BorderSide(color: event.color, width: 3)),
                ),
                child: Text(
                  event.title,
                  style: TextStyle(fontSize: 12, color: event.color, fontWeight: FontWeight.w600),
                ),
              ),
            );
          }),
        ],
      ],
    );
  }
}
