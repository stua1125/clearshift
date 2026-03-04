import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/shift_types.dart';
import '../../../../shared/models/shift_type.dart';

class ShiftTypesNotifier extends StateNotifier<List<ShiftType>> {
  ShiftTypesNotifier() : super(List.from(defaultShiftTypes));

  void add(ShiftType type) {
    state = [...state, type];
  }

  void update(ShiftType type) {
    state = [
      for (final t in state)
        if (t.id == type.id) type else t,
    ];
  }

  void remove(String id) {
    state = state.where((t) => t.id != id).toList();
  }

  void reorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex--;
    final items = List<ShiftType>.from(state);
    final item = items.removeAt(oldIndex);
    items.insert(newIndex, item);
    state = items;
  }
}

final shiftTypesProvider =
    StateNotifierProvider<ShiftTypesNotifier, List<ShiftType>>(
  (ref) => ShiftTypesNotifier(),
);
