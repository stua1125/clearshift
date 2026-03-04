// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_assignment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DailyAssignment _$DailyAssignmentFromJson(Map<String, dynamic> json) =>
    _DailyAssignment(
      id: json['id'] as String,
      scheduleId: json['scheduleId'] as String,
      day: (json['day'] as num).toInt(),
      shiftTypeId: json['shiftTypeId'] as String,
    );

Map<String, dynamic> _$DailyAssignmentToJson(_DailyAssignment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'scheduleId': instance.scheduleId,
      'day': instance.day,
      'shiftTypeId': instance.shiftTypeId,
    };
