import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'vacation_settings_provider.freezed.dart';

@freezed
abstract class VacationSettingsState with _$VacationSettingsState {
  const factory VacationSettingsState({
    @Default(3) int defaultMax,
    @Default({}) Map<int, int> overrides,
  }) = _VacationSettingsState;
}

class VacationSettingsNotifier extends StateNotifier<VacationSettingsState> {
  VacationSettingsNotifier() : super(const VacationSettingsState());

  void incrementDefault() {
    state = state.copyWith(defaultMax: state.defaultMax + 1);
  }

  void decrementDefault() {
    if (state.defaultMax > 0) {
      state = state.copyWith(defaultMax: state.defaultMax - 1);
    }
  }

  void addOverride(int day, int max) {
    final overrides = Map<int, int>.from(state.overrides);
    overrides[day] = max;
    state = state.copyWith(overrides: overrides);
  }

  void removeOverride(int day) {
    final overrides = Map<int, int>.from(state.overrides);
    overrides.remove(day);
    state = state.copyWith(overrides: overrides);
  }
}

final vacationSettingsProvider =
    StateNotifierProvider<VacationSettingsNotifier, VacationSettingsState>(
  (ref) => VacationSettingsNotifier(),
);
