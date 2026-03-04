// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'monthly_schedule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MonthlySchedule {

 String get id; String get userId; int get year; int get month;@SubmissionStatusConverter() SubmissionStatus get status; DateTime? get submittedAt;
/// Create a copy of MonthlySchedule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MonthlyScheduleCopyWith<MonthlySchedule> get copyWith => _$MonthlyScheduleCopyWithImpl<MonthlySchedule>(this as MonthlySchedule, _$identity);

  /// Serializes this MonthlySchedule to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MonthlySchedule&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.status, status) || other.status == status)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,year,month,status,submittedAt);

@override
String toString() {
  return 'MonthlySchedule(id: $id, userId: $userId, year: $year, month: $month, status: $status, submittedAt: $submittedAt)';
}


}

/// @nodoc
abstract mixin class $MonthlyScheduleCopyWith<$Res>  {
  factory $MonthlyScheduleCopyWith(MonthlySchedule value, $Res Function(MonthlySchedule) _then) = _$MonthlyScheduleCopyWithImpl;
@useResult
$Res call({
 String id, String userId, int year, int month,@SubmissionStatusConverter() SubmissionStatus status, DateTime? submittedAt
});




}
/// @nodoc
class _$MonthlyScheduleCopyWithImpl<$Res>
    implements $MonthlyScheduleCopyWith<$Res> {
  _$MonthlyScheduleCopyWithImpl(this._self, this._then);

  final MonthlySchedule _self;
  final $Res Function(MonthlySchedule) _then;

/// Create a copy of MonthlySchedule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? year = null,Object? month = null,Object? status = null,Object? submittedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SubmissionStatus,submittedAt: freezed == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [MonthlySchedule].
extension MonthlySchedulePatterns on MonthlySchedule {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MonthlySchedule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MonthlySchedule() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MonthlySchedule value)  $default,){
final _that = this;
switch (_that) {
case _MonthlySchedule():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MonthlySchedule value)?  $default,){
final _that = this;
switch (_that) {
case _MonthlySchedule() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  int year,  int month, @SubmissionStatusConverter()  SubmissionStatus status,  DateTime? submittedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MonthlySchedule() when $default != null:
return $default(_that.id,_that.userId,_that.year,_that.month,_that.status,_that.submittedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  int year,  int month, @SubmissionStatusConverter()  SubmissionStatus status,  DateTime? submittedAt)  $default,) {final _that = this;
switch (_that) {
case _MonthlySchedule():
return $default(_that.id,_that.userId,_that.year,_that.month,_that.status,_that.submittedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  int year,  int month, @SubmissionStatusConverter()  SubmissionStatus status,  DateTime? submittedAt)?  $default,) {final _that = this;
switch (_that) {
case _MonthlySchedule() when $default != null:
return $default(_that.id,_that.userId,_that.year,_that.month,_that.status,_that.submittedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MonthlySchedule implements MonthlySchedule {
  const _MonthlySchedule({required this.id, required this.userId, required this.year, required this.month, @SubmissionStatusConverter() this.status = SubmissionStatus.draft, this.submittedAt});
  factory _MonthlySchedule.fromJson(Map<String, dynamic> json) => _$MonthlyScheduleFromJson(json);

@override final  String id;
@override final  String userId;
@override final  int year;
@override final  int month;
@override@JsonKey()@SubmissionStatusConverter() final  SubmissionStatus status;
@override final  DateTime? submittedAt;

/// Create a copy of MonthlySchedule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MonthlyScheduleCopyWith<_MonthlySchedule> get copyWith => __$MonthlyScheduleCopyWithImpl<_MonthlySchedule>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MonthlyScheduleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MonthlySchedule&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.status, status) || other.status == status)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,year,month,status,submittedAt);

@override
String toString() {
  return 'MonthlySchedule(id: $id, userId: $userId, year: $year, month: $month, status: $status, submittedAt: $submittedAt)';
}


}

/// @nodoc
abstract mixin class _$MonthlyScheduleCopyWith<$Res> implements $MonthlyScheduleCopyWith<$Res> {
  factory _$MonthlyScheduleCopyWith(_MonthlySchedule value, $Res Function(_MonthlySchedule) _then) = __$MonthlyScheduleCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, int year, int month,@SubmissionStatusConverter() SubmissionStatus status, DateTime? submittedAt
});




}
/// @nodoc
class __$MonthlyScheduleCopyWithImpl<$Res>
    implements _$MonthlyScheduleCopyWith<$Res> {
  __$MonthlyScheduleCopyWithImpl(this._self, this._then);

  final _MonthlySchedule _self;
  final $Res Function(_MonthlySchedule) _then;

/// Create a copy of MonthlySchedule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? year = null,Object? month = null,Object? status = null,Object? submittedAt = freezed,}) {
  return _then(_MonthlySchedule(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SubmissionStatus,submittedAt: freezed == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
