import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
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
    return '$month월 $weekNum주차 ($weekStartDay~${_weekDays.last}일)';
  }

  /// 특정 날짜에 배정된 워커 목록을 반환
  List<_WorkerShift> _getWorkersForDay(int day) {
    final result = <_WorkerShift>[];
    for (final member in members) {
      final shift = member.assignments[day];
      if (shift != null) {
        result.add(_WorkerShift(name: member.userName, shift: shift));
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final weekDays = _weekDays;
    final now = DateTime.now();
    final isCurrentMonth = now.year == year && now.month == month;
    final totalCols = weekDays.length;

    final visibleEvents = events.where((e) {
      final start = DateTime(year, month, weekStartDay);
      final end = DateTime(year, month, weekDays.last);
      return !e.endDate.isBefore(start) && !e.startDate.isAfter(end);
    }).toList();

    return Column(
      children: [
        // Week navigator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed:
                  _canGoPrev ? () => onWeekChange?.call(_prevWeekStart) : null,
              icon: const Icon(Icons.chevron_left),
              iconSize: 24,
            ),
            Text(_weekLabel, style: Theme.of(context).textTheme.titleSmall),
            IconButton(
              onPressed:
                  _canGoNext ? () => onWeekChange?.call(_nextWeekStart) : null,
              icon: const Icon(Icons.chevron_right),
              iconSize: 24,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        // Day headers
        Row(
          children: weekDays.map((day) {
            final weekday = DateTime(year, month, day).weekday;
            final isToday = isCurrentMonth && now.day == day;
            return Expanded(
              child: _DayHeader(
                day: day,
                weekday: weekday,
                isToday: isToday,
              ),
            );
          }).toList(),
        ),
        const Divider(height: 1, color: AppColors.borderLight),
        // Event bars
        if (visibleEvents.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.xs),
          ...visibleEvents.map((event) {
            final eventStartDay = event.startDate.day;
            final eventEndDay = event.endDate.day;
            final firstCol =
                (eventStartDay - weekStartDay).clamp(0, totalCols - 1);
            final lastCol =
                (eventEndDay - weekStartDay).clamp(0, totalCols - 1);

            return Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Row(
                children: [
                  if (firstCol > 0) Spacer(flex: firstCol),
                  Expanded(
                    flex: lastCol - firstCol + 1,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: event.color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(4),
                        border: Border(
                            left: BorderSide(color: event.color, width: 3)),
                      ),
                      child: Text(
                        event.title,
                        style: TextStyle(
                          fontSize: 11,
                          color: event.color,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  if (lastCol < totalCols - 1)
                    Spacer(flex: totalCols - 1 - lastCol),
                ],
              ),
            );
          }),
          const SizedBox(height: AppSpacing.xs),
          const Divider(height: 1, color: AppColors.borderLight),
        ],
        // Google Calendar style: 7 day columns with workers stacked vertically
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: weekDays.map((day) {
              final workers = _getWorkersForDay(day);
              final isLast = day == weekDays.last;
              return Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: isLast
                        ? null
                        : const Border(
                            right: BorderSide(
                              color: AppColors.borderLight,
                              width: 0.5,
                            ),
                          ),
                  ),
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 2,
                      vertical: AppSpacing.xs,
                    ),
                    itemCount: workers.length,
                    itemBuilder: (context, index) {
                      return _WorkerCard(worker: workers[index]);
                    },
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _WorkerShift {
  const _WorkerShift({required this.name, required this.shift});
  final String name;
  final ShiftType shift;
}

class _DayHeader extends StatelessWidget {
  const _DayHeader({
    required this.day,
    required this.weekday,
    required this.isToday,
  });

  final int day;
  final int weekday;
  final bool isToday;

  static const _weekdayLabels = ['', '월', '화', '수', '목', '금', '토', '일'];

  @override
  Widget build(BuildContext context) {
    final isSunday = weekday == 7;
    final isSaturday = weekday == 6;

    final dayColor = isToday
        ? AppColors.primary
        : isSunday
            ? AppColors.calendarSunday
            : isSaturday
                ? AppColors.calendarSaturday
                : AppColors.textPrimary;

    final labelColor = isSunday
        ? AppColors.calendarSunday
        : isSaturday
            ? AppColors.calendarSaturday
            : AppColors.textSecondary;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      decoration: isToday
          ? BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(AppSpacing.sm),
            )
          : null,
      child: Column(
        children: [
          Text(
            _weekdayLabels[weekday],
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: labelColor,
            ),
          ),
          const SizedBox(height: 2),
          Container(
            width: 28,
            height: 28,
            decoration: isToday
                ? const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  )
                : null,
            alignment: Alignment.center,
            child: Text(
              '$day',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: isToday ? AppColors.onPrimary : dayColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Google Calendar 스타일 — 각 날짜 열 안에 세로로 쌓이는 워커 카드
class _WorkerCard extends StatelessWidget {
  const _WorkerCard({required this.worker});

  final _WorkerShift worker;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 3),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        color: worker.shift.bgColor,
        borderRadius: BorderRadius.circular(6),
        border: Border(
          left: BorderSide(color: worker.shift.color, width: 3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            worker.shift.abbreviation,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: worker.shift.color,
            ),
          ),
          Text(
            worker.name,
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w500,
              color: worker.shift.color.withValues(alpha: 0.8),
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
