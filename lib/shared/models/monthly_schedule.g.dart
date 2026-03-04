// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monthly_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MonthlySchedule _$MonthlyScheduleFromJson(Map<String, dynamic> json) =>
    _MonthlySchedule(
      id: json['id'] as String,
      userId: json['userId'] as String,
      year: (json['year'] as num).toInt(),
      month: (json['month'] as num).toInt(),
      status: json['status'] == null
          ? SubmissionStatus.draft
          : const SubmissionStatusConverter().fromJson(
              json['status'] as String,
            ),
      submittedAt: json['submittedAt'] == null
          ? null
          : DateTime.parse(json['submittedAt'] as String),
    );

Map<String, dynamic> _$MonthlyScheduleToJson(_MonthlySchedule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'year': instance.year,
      'month': instance.month,
      'status': const SubmissionStatusConverter().toJson(instance.status),
      'submittedAt': instance.submittedAt?.toIso8601String(),
    };
