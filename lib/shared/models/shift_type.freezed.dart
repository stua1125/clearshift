// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shift_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ShiftType {

 String get id; String get name; String get abbreviation;@ColorConverter() Color get color;@ColorConverter() Color get bgColor; ShiftCategory get category; int get sortOrder; bool get isActive; String? get startTime; String? get endTime;
/// Create a copy of ShiftType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShiftTypeCopyWith<ShiftType> get copyWith => _$ShiftTypeCopyWithImpl<ShiftType>(this as ShiftType, _$identity);

  /// Serializes this ShiftType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShiftType&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.abbreviation, abbreviation) || other.abbreviation == abbreviation)&&(identical(other.color, color) || other.color == color)&&(identical(other.bgColor, bgColor) || other.bgColor == bgColor)&&(identical(other.category, category) || other.category == category)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,abbreviation,color,bgColor,category,sortOrder,isActive,startTime,endTime);

@override
String toString() {
  return 'ShiftType(id: $id, name: $name, abbreviation: $abbreviation, color: $color, bgColor: $bgColor, category: $category, sortOrder: $sortOrder, isActive: $isActive, startTime: $startTime, endTime: $endTime)';
}


}

/// @nodoc
abstract mixin class $ShiftTypeCopyWith<$Res>  {
  factory $ShiftTypeCopyWith(ShiftType value, $Res Function(ShiftType) _then) = _$ShiftTypeCopyWithImpl;
@useResult
$Res call({
 String id, String name, String abbreviation,@ColorConverter() Color color,@ColorConverter() Color bgColor, ShiftCategory category, int sortOrder, bool isActive, String? startTime, String? endTime
});




}
/// @nodoc
class _$ShiftTypeCopyWithImpl<$Res>
    implements $ShiftTypeCopyWith<$Res> {
  _$ShiftTypeCopyWithImpl(this._self, this._then);

  final ShiftType _self;
  final $Res Function(ShiftType) _then;

/// Create a copy of ShiftType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? abbreviation = null,Object? color = null,Object? bgColor = null,Object? category = null,Object? sortOrder = null,Object? isActive = null,Object? startTime = freezed,Object? endTime = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,abbreviation: null == abbreviation ? _self.abbreviation : abbreviation // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as Color,bgColor: null == bgColor ? _self.bgColor : bgColor // ignore: cast_nullable_to_non_nullable
as Color,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ShiftCategory,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String?,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ShiftType].
extension ShiftTypePatterns on ShiftType {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShiftType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShiftType() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShiftType value)  $default,){
final _that = this;
switch (_that) {
case _ShiftType():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShiftType value)?  $default,){
final _that = this;
switch (_that) {
case _ShiftType() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String abbreviation, @ColorConverter()  Color color, @ColorConverter()  Color bgColor,  ShiftCategory category,  int sortOrder,  bool isActive,  String? startTime,  String? endTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShiftType() when $default != null:
return $default(_that.id,_that.name,_that.abbreviation,_that.color,_that.bgColor,_that.category,_that.sortOrder,_that.isActive,_that.startTime,_that.endTime);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String abbreviation, @ColorConverter()  Color color, @ColorConverter()  Color bgColor,  ShiftCategory category,  int sortOrder,  bool isActive,  String? startTime,  String? endTime)  $default,) {final _that = this;
switch (_that) {
case _ShiftType():
return $default(_that.id,_that.name,_that.abbreviation,_that.color,_that.bgColor,_that.category,_that.sortOrder,_that.isActive,_that.startTime,_that.endTime);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String abbreviation, @ColorConverter()  Color color, @ColorConverter()  Color bgColor,  ShiftCategory category,  int sortOrder,  bool isActive,  String? startTime,  String? endTime)?  $default,) {final _that = this;
switch (_that) {
case _ShiftType() when $default != null:
return $default(_that.id,_that.name,_that.abbreviation,_that.color,_that.bgColor,_that.category,_that.sortOrder,_that.isActive,_that.startTime,_that.endTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShiftType implements ShiftType {
  const _ShiftType({required this.id, required this.name, required this.abbreviation, @ColorConverter() required this.color, @ColorConverter() required this.bgColor, required this.category, this.sortOrder = 0, this.isActive = true, this.startTime, this.endTime});
  factory _ShiftType.fromJson(Map<String, dynamic> json) => _$ShiftTypeFromJson(json);

@override final  String id;
@override final  String name;
@override final  String abbreviation;
@override@ColorConverter() final  Color color;
@override@ColorConverter() final  Color bgColor;
@override final  ShiftCategory category;
@override@JsonKey() final  int sortOrder;
@override@JsonKey() final  bool isActive;
@override final  String? startTime;
@override final  String? endTime;

/// Create a copy of ShiftType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShiftTypeCopyWith<_ShiftType> get copyWith => __$ShiftTypeCopyWithImpl<_ShiftType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShiftTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShiftType&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.abbreviation, abbreviation) || other.abbreviation == abbreviation)&&(identical(other.color, color) || other.color == color)&&(identical(other.bgColor, bgColor) || other.bgColor == bgColor)&&(identical(other.category, category) || other.category == category)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,abbreviation,color,bgColor,category,sortOrder,isActive,startTime,endTime);

@override
String toString() {
  return 'ShiftType(id: $id, name: $name, abbreviation: $abbreviation, color: $color, bgColor: $bgColor, category: $category, sortOrder: $sortOrder, isActive: $isActive, startTime: $startTime, endTime: $endTime)';
}


}

/// @nodoc
abstract mixin class _$ShiftTypeCopyWith<$Res> implements $ShiftTypeCopyWith<$Res> {
  factory _$ShiftTypeCopyWith(_ShiftType value, $Res Function(_ShiftType) _then) = __$ShiftTypeCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String abbreviation,@ColorConverter() Color color,@ColorConverter() Color bgColor, ShiftCategory category, int sortOrder, bool isActive, String? startTime, String? endTime
});




}
/// @nodoc
class __$ShiftTypeCopyWithImpl<$Res>
    implements _$ShiftTypeCopyWith<$Res> {
  __$ShiftTypeCopyWithImpl(this._self, this._then);

  final _ShiftType _self;
  final $Res Function(_ShiftType) _then;

/// Create a copy of ShiftType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? abbreviation = null,Object? color = null,Object? bgColor = null,Object? category = null,Object? sortOrder = null,Object? isActive = null,Object? startTime = freezed,Object? endTime = freezed,}) {
  return _then(_ShiftType(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,abbreviation: null == abbreviation ? _self.abbreviation : abbreviation // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as Color,bgColor: null == bgColor ? _self.bgColor : bgColor // ignore: cast_nullable_to_non_nullable
as Color,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ShiftCategory,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String?,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
