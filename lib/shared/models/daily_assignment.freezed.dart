// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_assignment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DailyAssignment {

 String get id; String get scheduleId; int get day; String get shiftTypeId;
/// Create a copy of DailyAssignment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyAssignmentCopyWith<DailyAssignment> get copyWith => _$DailyAssignmentCopyWithImpl<DailyAssignment>(this as DailyAssignment, _$identity);

  /// Serializes this DailyAssignment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyAssignment&&(identical(other.id, id) || other.id == id)&&(identical(other.scheduleId, scheduleId) || other.scheduleId == scheduleId)&&(identical(other.day, day) || other.day == day)&&(identical(other.shiftTypeId, shiftTypeId) || other.shiftTypeId == shiftTypeId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,scheduleId,day,shiftTypeId);

@override
String toString() {
  return 'DailyAssignment(id: $id, scheduleId: $scheduleId, day: $day, shiftTypeId: $shiftTypeId)';
}


}

/// @nodoc
abstract mixin class $DailyAssignmentCopyWith<$Res>  {
  factory $DailyAssignmentCopyWith(DailyAssignment value, $Res Function(DailyAssignment) _then) = _$DailyAssignmentCopyWithImpl;
@useResult
$Res call({
 String id, String scheduleId, int day, String shiftTypeId
});




}
/// @nodoc
class _$DailyAssignmentCopyWithImpl<$Res>
    implements $DailyAssignmentCopyWith<$Res> {
  _$DailyAssignmentCopyWithImpl(this._self, this._then);

  final DailyAssignment _self;
  final $Res Function(DailyAssignment) _then;

/// Create a copy of DailyAssignment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? scheduleId = null,Object? day = null,Object? shiftTypeId = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,scheduleId: null == scheduleId ? _self.scheduleId : scheduleId // ignore: cast_nullable_to_non_nullable
as String,day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as int,shiftTypeId: null == shiftTypeId ? _self.shiftTypeId : shiftTypeId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DailyAssignment].
extension DailyAssignmentPatterns on DailyAssignment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyAssignment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyAssignment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyAssignment value)  $default,){
final _that = this;
switch (_that) {
case _DailyAssignment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyAssignment value)?  $default,){
final _that = this;
switch (_that) {
case _DailyAssignment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String scheduleId,  int day,  String shiftTypeId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyAssignment() when $default != null:
return $default(_that.id,_that.scheduleId,_that.day,_that.shiftTypeId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String scheduleId,  int day,  String shiftTypeId)  $default,) {final _that = this;
switch (_that) {
case _DailyAssignment():
return $default(_that.id,_that.scheduleId,_that.day,_that.shiftTypeId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String scheduleId,  int day,  String shiftTypeId)?  $default,) {final _that = this;
switch (_that) {
case _DailyAssignment() when $default != null:
return $default(_that.id,_that.scheduleId,_that.day,_that.shiftTypeId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DailyAssignment implements DailyAssignment {
  const _DailyAssignment({required this.id, required this.scheduleId, required this.day, required this.shiftTypeId});
  factory _DailyAssignment.fromJson(Map<String, dynamic> json) => _$DailyAssignmentFromJson(json);

@override final  String id;
@override final  String scheduleId;
@override final  int day;
@override final  String shiftTypeId;

/// Create a copy of DailyAssignment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyAssignmentCopyWith<_DailyAssignment> get copyWith => __$DailyAssignmentCopyWithImpl<_DailyAssignment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DailyAssignmentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyAssignment&&(identical(other.id, id) || other.id == id)&&(identical(other.scheduleId, scheduleId) || other.scheduleId == scheduleId)&&(identical(other.day, day) || other.day == day)&&(identical(other.shiftTypeId, shiftTypeId) || other.shiftTypeId == shiftTypeId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,scheduleId,day,shiftTypeId);

@override
String toString() {
  return 'DailyAssignment(id: $id, scheduleId: $scheduleId, day: $day, shiftTypeId: $shiftTypeId)';
}


}

/// @nodoc
abstract mixin class _$DailyAssignmentCopyWith<$Res> implements $DailyAssignmentCopyWith<$Res> {
  factory _$DailyAssignmentCopyWith(_DailyAssignment value, $Res Function(_DailyAssignment) _then) = __$DailyAssignmentCopyWithImpl;
@override @useResult
$Res call({
 String id, String scheduleId, int day, String shiftTypeId
});




}
/// @nodoc
class __$DailyAssignmentCopyWithImpl<$Res>
    implements _$DailyAssignmentCopyWith<$Res> {
  __$DailyAssignmentCopyWithImpl(this._self, this._then);

  final _DailyAssignment _self;
  final $Res Function(_DailyAssignment) _then;

/// Create a copy of DailyAssignment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? scheduleId = null,Object? day = null,Object? shiftTypeId = null,}) {
  return _then(_DailyAssignment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,scheduleId: null == scheduleId ? _self.scheduleId : scheduleId // ignore: cast_nullable_to_non_nullable
as String,day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as int,shiftTypeId: null == shiftTypeId ? _self.shiftTypeId : shiftTypeId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
