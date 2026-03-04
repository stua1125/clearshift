import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shift_type.freezed.dart';
part 'shift_type.g.dart';

enum ShiftCategory { work, leave, other }

@freezed
abstract class ShiftType with _$ShiftType {
  const factory ShiftType({
    required String id,
    required String name,
    required String abbreviation,
    @ColorConverter() required Color color,
    @ColorConverter() required Color bgColor,
    required ShiftCategory category,
    @Default(0) int sortOrder,
    @Default(true) bool isActive,
  }) = _ShiftType;

  factory ShiftType.fromJson(Map<String, dynamic> json) =>
      _$ShiftTypeFromJson(json);
}

class ColorConverter implements JsonConverter<Color, int> {
  const ColorConverter();

  @override
  Color fromJson(int json) => Color(json);

  @override
  int toJson(Color object) => object.toARGB32();
}
