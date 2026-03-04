import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/widgets/submit_bar.dart';

part 'monthly_schedule.freezed.dart';
part 'monthly_schedule.g.dart';

@freezed
abstract class MonthlySchedule with _$MonthlySchedule {
  const factory MonthlySchedule({
    required String id,
    required String userId,
    required int year,
    required int month,
    @Default(SubmissionStatus.draft) @SubmissionStatusConverter() SubmissionStatus status,
    DateTime? submittedAt,
  }) = _MonthlySchedule;

  factory MonthlySchedule.fromJson(Map<String, dynamic> json) =>
      _$MonthlyScheduleFromJson(json);
}

class SubmissionStatusConverter
    implements JsonConverter<SubmissionStatus, String> {
  const SubmissionStatusConverter();

  @override
  SubmissionStatus fromJson(String json) => SubmissionStatus.values.byName(json);

  @override
  String toJson(SubmissionStatus object) => object.name;
}
