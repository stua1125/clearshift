// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CalendarEvent _$CalendarEventFromJson(Map<String, dynamic> json) =>
    _CalendarEvent(
      id: json['id'] as String,
      teamId: json['teamId'] as String,
      title: json['title'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      color: const ColorConverter().fromJson((json['color'] as num).toInt()),
      memo: json['memo'] as String?,
    );

Map<String, dynamic> _$CalendarEventToJson(_CalendarEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'teamId': instance.teamId,
      'title': instance.title,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'color': const ColorConverter().toJson(instance.color),
      'memo': instance.memo,
    };
