import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/constants/shift_types.dart';
import '../../../../../core/widgets/submit_bar.dart';
import '../../../../../shared/models/shift_type.dart';

part 'calendar_provider.freezed.dart';

@freezed
abstract class CalendarState with _$CalendarState {
  const factory CalendarState({
    required int year,
    required int month,
    @Default({}) Map<int, ShiftType> assignments,
    @Default(false) bool paintMode,
    ShiftType? selectedShiftType,
    @Default(SubmissionStatus.draft) SubmissionStatus submissionStatus,
    @Default([]) List<ShiftType> shiftTypes,
  }) = _CalendarState;
}

class WorkerCalendarNotifier extends StateNotifier<CalendarState> {
  WorkerCalendarNotifier()
      : super(CalendarState(
          year: DateTime.now().year,
          month: DateTime.now().month,
          shiftTypes: defaultShiftTypes,
        ));

  int get _daysInMonth => DateTime(state.year, state.month + 1, 0).day;

  void selectShiftType(ShiftType? type) {
    state = state.copyWith(selectedShiftType: type);
  }

  void togglePaintMode() {
    state = state.copyWith(paintMode: !state.paintMode);
  }

  void tapDay(int day) {
    if (!state.paintMode) return;
    if (state.submissionStatus == SubmissionStatus.submitted ||
        state.submissionStatus == SubmissionStatus.approved) {
      return;
    }

    final assignments = Map<int, ShiftType>.from(state.assignments);
    final selectedType = state.selectedShiftType;

    if (selectedType == null) {
      // Erase mode
      assignments.remove(day);
    } else if (assignments[day]?.id == selectedType.id) {
      // Toggle off
      assignments.remove(day);
    } else {
      // Assign
      assignments[day] = selectedType;
    }

    state = state.copyWith(assignments: assignments);
  }

  void submitSchedule() {
    if (state.assignments.length < _daysInMonth) return;
    state = state.copyWith(submissionStatus: SubmissionStatus.submitted);
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
      assignments: {},
      submissionStatus: SubmissionStatus.draft,
    );
  }
}

final workerCalendarProvider =
    StateNotifierProvider<WorkerCalendarNotifier, CalendarState>(
  (ref) => WorkerCalendarNotifier(),
);
