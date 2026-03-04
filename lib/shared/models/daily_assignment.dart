import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_assignment.freezed.dart';
part 'daily_assignment.g.dart';

@freezed
abstract class DailyAssignment with _$DailyAssignment {
  const factory DailyAssignment({
    required String id,
    required String scheduleId,
    required int day,
    required String shiftTypeId,
  }) = _DailyAssignment;

  factory DailyAssignment.fromJson(Map<String, dynamic> json) =>
      _$DailyAssignmentFromJson(json);
}
