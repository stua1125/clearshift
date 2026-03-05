import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/widgets/shared_day_cell.dart';
import '../../../../shared/models/calendar_event.dart';
import '../../../../shared/models/shift_type.dart';

part 'shared_calendar_provider.freezed.dart';

enum CalendarViewMode { monthly, weekly }

@freezed
abstract class MemberWeekRow with _$MemberWeekRow {
  const factory MemberWeekRow({
    required String userId,
    required String userName,
    String? profileImageUrl,
    @Default({}) Map<int, ShiftType> assignments,
  }) = _MemberWeekRow;
}

@freezed
abstract class SharedCalendarState with _$SharedCalendarState {
  const factory SharedCalendarState({
    required int year,
    required int month,
    @Default(CalendarViewMode.monthly) CalendarViewMode viewMode,
    @Default({}) Map<int, DayShiftSummary> daySummaries,
    @Default([]) List<MemberWeekRow> weekMembers,
    @Default([]) List<CalendarEvent> events,
    @Default(1) int selectedWeekStartDay,
    @Default(false) bool isLoading,
  }) = _SharedCalendarState;
}

class SharedCalendarNotifier extends StateNotifier<SharedCalendarState> {
  SharedCalendarNotifier()
      : super(SharedCalendarState(
          year: DateTime.now().year,
          month: DateTime.now().month,
        )) {
    _loadMockData();
  }

  void switchView(CalendarViewMode mode) {
    state = state.copyWith(viewMode: mode);
    if (mode == CalendarViewMode.weekly) {
      _loadWeeklyMock();
    }
  }

  void navigateMonth(int delta) {
    var year = state.year;
    var month = state.month + delta;
    if (month > 12) {
      month = 1;
      year++;
    } else if (month < 1) {
      month = 12;
      year--;
    }
    state = state.copyWith(
      year: year,
      month: month,
      selectedWeekStartDay: 1,
    );
    _loadMockData();
    if (state.viewMode == CalendarViewMode.weekly) {
      _loadWeeklyMock();
    }
  }

  void selectWeek(int weekStartDay) {
    state = state.copyWith(selectedWeekStartDay: weekStartDay);
    _loadWeeklyMock();
  }

  void _loadMockData() {
    // Mock shift count data
    final Map<int, DayShiftSummary> summaries = {};
    final daysInMonth = DateTime(state.year, state.month + 1, 0).day;

    for (int day = 1; day <= daysInMonth; day++) {
      summaries[day] = DayShiftSummary(
        shiftCounts: [
          ShiftCountData(
            abbreviation: 'D',
            count: 3 + (day % 2),
            color: const Color(0xFF3B82F6),
            bgColor: const Color(0xFFDBEAFE),
          ),
          ShiftCountData(
            abbreviation: 'N',
            count: 2,
            color: const Color(0xFF7C3AED),
            bgColor: const Color(0xFFEDE9FE),
          ),
          ShiftCountData(
            abbreviation: 'OFF',
            count: 1 + (day % 3),
            color: const Color(0xFF10B981),
            bgColor: const Color(0xFFD1FAE5),
          ),
        ],
        totalMembers: 8,
        submittedCount: 6,
      );
    }

    final events = [
      CalendarEvent(
        id: 'e1',
        teamId: 'branch1',
        title: '정기 교육',
        startDate: DateTime(state.year, state.month, 5),
        endDate: DateTime(state.year, state.month, 7),
        color: const Color(0xFF3B82F6),
      ),
      CalendarEvent(
        id: 'e2',
        teamId: 'branch1',
        title: '안전 점검',
        startDate: DateTime(state.year, state.month, 15),
        endDate: DateTime(state.year, state.month, 15),
        color: const Color(0xFFEF4444),
      ),
    ];

    state = state.copyWith(daySummaries: summaries, events: events);
  }

  void _loadWeeklyMock() {
    final shiftDay = ShiftType(
      id: 'day',
      name: '주간',
      abbreviation: 'D',
      color: const Color(0xFF3B82F6),
      bgColor: const Color(0xFFDBEAFE),
      category: ShiftCategory.work,
    );
    final shiftNight = ShiftType(
      id: 'night',
      name: '야간',
      abbreviation: 'N',
      color: const Color(0xFF7C3AED),
      bgColor: const Color(0xFFEDE9FE),
      category: ShiftCategory.work,
    );
    final shiftOff = ShiftType(
      id: 'off',
      name: '휴무',
      abbreviation: 'OFF',
      color: const Color(0xFF10B981),
      bgColor: const Color(0xFFD1FAE5),
      category: ShiftCategory.leave,
    );

    final ws = state.selectedWeekStartDay;
    final members = [
      MemberWeekRow(userId: 'u1', userName: '김철수', assignments: {
        ws: shiftDay,
        ws + 1: shiftDay,
        ws + 2: shiftNight,
        ws + 3: shiftNight,
        ws + 4: shiftOff,
        ws + 5: shiftOff,
        ws + 6: shiftDay,
      }),
      MemberWeekRow(userId: 'u2', userName: '이영희', assignments: {
        ws: shiftNight,
        ws + 1: shiftNight,
        ws + 2: shiftDay,
        ws + 3: shiftDay,
        ws + 4: shiftDay,
        ws + 5: shiftOff,
        ws + 6: shiftOff,
      }),
      MemberWeekRow(userId: 'u3', userName: '박지민', assignments: {
        ws: shiftOff,
        ws + 1: shiftDay,
        ws + 2: shiftDay,
        ws + 3: shiftDay,
        ws + 4: shiftNight,
        ws + 5: shiftNight,
        ws + 6: shiftOff,
      }),
    ];

    state = state.copyWith(weekMembers: members);
  }
}

final sharedCalendarProvider =
    StateNotifierProvider<SharedCalendarNotifier, SharedCalendarState>(
  (ref) => SharedCalendarNotifier(),
);
