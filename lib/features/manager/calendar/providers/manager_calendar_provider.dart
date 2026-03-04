import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/widgets/submit_bar.dart';
import '../../../../shared/models/calendar_event.dart';
import '../../../../shared/models/shift_type.dart';

part 'manager_calendar_provider.freezed.dart';

@freezed
abstract class TeamMember with _$TeamMember {
  const factory TeamMember({
    required String id,
    required String name,
    required SubmissionStatus status,
    @Default(0) int filledPercent,
    @Default({}) Map<int, ShiftType> assignments,
  }) = _TeamMember;
}

@freezed
abstract class ManagerCalendarState with _$ManagerCalendarState {
  const ManagerCalendarState._();

  const factory ManagerCalendarState({
    required int year,
    required int month,
    @Default([]) List<CalendarEvent> events,
    @Default([]) List<TeamMember> teamMembers,
    @Default(3) int defaultVacationMax,
    @Default({}) Map<int, int> vacationOverrides,
    @Default({}) Map<int, int> vacationCounts,
  }) = _ManagerCalendarState;

  Map<String, ShiftType?> getMemberAssignments(int day) {
    final result = <String, ShiftType?>{};
    for (final member in teamMembers) {
      result[member.name] = member.assignments[day];
    }
    return result;
  }
}

class ManagerCalendarNotifier extends StateNotifier<ManagerCalendarState> {
  ManagerCalendarNotifier()
      : super(ManagerCalendarState(
          year: DateTime.now().year,
          month: DateTime.now().month,
          teamMembers: _mockTeamMembers(),
        ));

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
    state = state.copyWith(year: year, month: month);
  }

  static List<TeamMember> _mockTeamMembers() {
    return const [
      TeamMember(
        id: '1',
        name: '김민수',
        status: SubmissionStatus.submitted,
        filledPercent: 100,
      ),
      TeamMember(
        id: '2',
        name: '이서연',
        status: SubmissionStatus.draft,
        filledPercent: 73,
      ),
      TeamMember(
        id: '3',
        name: '박지훈',
        status: SubmissionStatus.draft,
        filledPercent: 45,
      ),
    ];
  }
}

final managerCalendarProvider =
    StateNotifierProvider<ManagerCalendarNotifier, ManagerCalendarState>(
  (ref) => ManagerCalendarNotifier(),
);
