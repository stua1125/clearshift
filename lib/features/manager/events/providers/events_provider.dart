import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/models/calendar_event.dart';

class EventsNotifier extends StateNotifier<List<CalendarEvent>> {
  EventsNotifier() : super([]);

  void add(CalendarEvent event) {
    state = [...state, event];
  }

  void update(CalendarEvent event) {
    state = [
      for (final e in state)
        if (e.id == event.id) event else e,
    ];
  }

  void remove(String id) {
    state = state.where((e) => e.id != id).toList();
  }
}

final eventsProvider =
    StateNotifierProvider<EventsNotifier, List<CalendarEvent>>(
  (ref) => EventsNotifier(),
);
