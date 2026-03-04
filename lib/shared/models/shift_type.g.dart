// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shift_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ShiftType _$ShiftTypeFromJson(Map<String, dynamic> json) => _ShiftType(
  id: json['id'] as String,
  name: json['name'] as String,
  abbreviation: json['abbreviation'] as String,
  color: const ColorConverter().fromJson((json['color'] as num).toInt()),
  bgColor: const ColorConverter().fromJson((json['bgColor'] as num).toInt()),
  category: $enumDecode(_$ShiftCategoryEnumMap, json['category']),
  sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
  isActive: json['isActive'] as bool? ?? true,
);

Map<String, dynamic> _$ShiftTypeToJson(_ShiftType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'abbreviation': instance.abbreviation,
      'color': const ColorConverter().toJson(instance.color),
      'bgColor': const ColorConverter().toJson(instance.bgColor),
      'category': _$ShiftCategoryEnumMap[instance.category]!,
      'sortOrder': instance.sortOrder,
      'isActive': instance.isActive,
    };

const _$ShiftCategoryEnumMap = {
  ShiftCategory.work: 'work',
  ShiftCategory.leave: 'leave',
  ShiftCategory.other: 'other',
};
