import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'shift_type.dart';

part 'calendar_event.freezed.dart';
part 'calendar_event.g.dart';

@freezed
abstract class CalendarEvent with _$CalendarEvent {
  const factory CalendarEvent({
    required String id,
    required String teamId,
    required String title,
    required DateTime startDate,
    required DateTime endDate,
    @ColorConverter() required Color color,
    String? memo,
  }) = _CalendarEvent;

  factory CalendarEvent.fromJson(Map<String, dynamic> json) =>
      _$CalendarEventFromJson(json);
}
