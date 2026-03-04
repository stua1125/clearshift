// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CalendarState {

 int get year; int get month; Map<int, ShiftType> get assignments; bool get paintMode; ShiftType? get selectedShiftType; SubmissionStatus get submissionStatus; List<ShiftType> get shiftTypes;
/// Create a copy of CalendarState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarStateCopyWith<CalendarState> get copyWith => _$CalendarStateCopyWithImpl<CalendarState>(this as CalendarState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarState&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&const DeepCollectionEquality().equals(other.assignments, assignments)&&(identical(other.paintMode, paintMode) || other.paintMode == paintMode)&&(identical(other.selectedShiftType, selectedShiftType) || other.selectedShiftType == selectedShiftType)&&(identical(other.submissionStatus, submissionStatus) || other.submissionStatus == submissionStatus)&&const DeepCollectionEquality().equals(other.shiftTypes, shiftTypes));
}


@override
int get hashCode => Object.hash(runtimeType,year,month,const DeepCollectionEquality().hash(assignments),paintMode,selectedShiftType,submissionStatus,const DeepCollectionEquality().hash(shiftTypes));

@override
String toString() {
  return 'CalendarState(year: $year, month: $month, assignments: $assignments, paintMode: $paintMode, selectedShiftType: $selectedShiftType, submissionStatus: $submissionStatus, shiftTypes: $shiftTypes)';
}


}

/// @nodoc
abstract mixin class $CalendarStateCopyWith<$Res>  {
  factory $CalendarStateCopyWith(CalendarState value, $Res Function(CalendarState) _then) = _$CalendarStateCopyWithImpl;
@useResult
$Res call({
 int year, int month, Map<int, ShiftType> assignments, bool paintMode, ShiftType? selectedShiftType, SubmissionStatus submissionStatus, List<ShiftType> shiftTypes
});


$ShiftTypeCopyWith<$Res>? get selectedShiftType;

}
/// @nodoc
class _$CalendarStateCopyWithImpl<$Res>
    implements $CalendarStateCopyWith<$Res> {
  _$CalendarStateCopyWithImpl(this._self, this._then);

  final CalendarState _self;
  final $Res Function(CalendarState) _then;

/// Create a copy of CalendarState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? year = null,Object? month = null,Object? assignments = null,Object? paintMode = null,Object? selectedShiftType = freezed,Object? submissionStatus = null,Object? shiftTypes = null,}) {
  return _then(_self.copyWith(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,assignments: null == assignments ? _self.assignments : assignments // ignore: cast_nullable_to_non_nullable
as Map<int, ShiftType>,paintMode: null == paintMode ? _self.paintMode : paintMode // ignore: cast_nullable_to_non_nullable
as bool,selectedShiftType: freezed == selectedShiftType ? _self.selectedShiftType : selectedShiftType // ignore: cast_nullable_to_non_nullable
as ShiftType?,submissionStatus: null == submissionStatus ? _self.submissionStatus : submissionStatus // ignore: cast_nullable_to_non_nullable
as SubmissionStatus,shiftTypes: null == shiftTypes ? _self.shiftTypes : shiftTypes // ignore: cast_nullable_to_non_nullable
as List<ShiftType>,
  ));
}
/// Create a copy of CalendarState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShiftTypeCopyWith<$Res>? get selectedShiftType {
    if (_self.selectedShiftType == null) {
    return null;
  }

  return $ShiftTypeCopyWith<$Res>(_self.selectedShiftType!, (value) {
    return _then(_self.copyWith(selectedShiftType: value));
  });
}
}


/// Adds pattern-matching-related methods to [CalendarState].
extension CalendarStatePatterns on CalendarState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalendarState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalendarState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalendarState value)  $default,){
final _that = this;
switch (_that) {
case _CalendarState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalendarState value)?  $default,){
final _that = this;
switch (_that) {
case _CalendarState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int year,  int month,  Map<int, ShiftType> assignments,  bool paintMode,  ShiftType? selectedShiftType,  SubmissionStatus submissionStatus,  List<ShiftType> shiftTypes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalendarState() when $default != null:
return $default(_that.year,_that.month,_that.assignments,_that.paintMode,_that.selectedShiftType,_that.submissionStatus,_that.shiftTypes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int year,  int month,  Map<int, ShiftType> assignments,  bool paintMode,  ShiftType? selectedShiftType,  SubmissionStatus submissionStatus,  List<ShiftType> shiftTypes)  $default,) {final _that = this;
switch (_that) {
case _CalendarState():
return $default(_that.year,_that.month,_that.assignments,_that.paintMode,_that.selectedShiftType,_that.submissionStatus,_that.shiftTypes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int year,  int month,  Map<int, ShiftType> assignments,  bool paintMode,  ShiftType? selectedShiftType,  SubmissionStatus submissionStatus,  List<ShiftType> shiftTypes)?  $default,) {final _that = this;
switch (_that) {
case _CalendarState() when $default != null:
return $default(_that.year,_that.month,_that.assignments,_that.paintMode,_that.selectedShiftType,_that.submissionStatus,_that.shiftTypes);case _:
  return null;

}
}

}

/// @nodoc


class _CalendarState implements CalendarState {
  const _CalendarState({required this.year, required this.month, final  Map<int, ShiftType> assignments = const {}, this.paintMode = false, this.selectedShiftType, this.submissionStatus = SubmissionStatus.draft, final  List<ShiftType> shiftTypes = const []}): _assignments = assignments,_shiftTypes = shiftTypes;
  

@override final  int year;
@override final  int month;
 final  Map<int, ShiftType> _assignments;
@override@JsonKey() Map<int, ShiftType> get assignments {
  if (_assignments is EqualUnmodifiableMapView) return _assignments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_assignments);
}

@override@JsonKey() final  bool paintMode;
@override final  ShiftType? selectedShiftType;
@override@JsonKey() final  SubmissionStatus submissionStatus;
 final  List<ShiftType> _shiftTypes;
@override@JsonKey() List<ShiftType> get shiftTypes {
  if (_shiftTypes is EqualUnmodifiableListView) return _shiftTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_shiftTypes);
}


/// Create a copy of CalendarState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalendarStateCopyWith<_CalendarState> get copyWith => __$CalendarStateCopyWithImpl<_CalendarState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarState&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&const DeepCollectionEquality().equals(other._assignments, _assignments)&&(identical(other.paintMode, paintMode) || other.paintMode == paintMode)&&(identical(other.selectedShiftType, selectedShiftType) || other.selectedShiftType == selectedShiftType)&&(identical(other.submissionStatus, submissionStatus) || other.submissionStatus == submissionStatus)&&const DeepCollectionEquality().equals(other._shiftTypes, _shiftTypes));
}


@override
int get hashCode => Object.hash(runtimeType,year,month,const DeepCollectionEquality().hash(_assignments),paintMode,selectedShiftType,submissionStatus,const DeepCollectionEquality().hash(_shiftTypes));

@override
String toString() {
  return 'CalendarState(year: $year, month: $month, assignments: $assignments, paintMode: $paintMode, selectedShiftType: $selectedShiftType, submissionStatus: $submissionStatus, shiftTypes: $shiftTypes)';
}


}

/// @nodoc
abstract mixin class _$CalendarStateCopyWith<$Res> implements $CalendarStateCopyWith<$Res> {
  factory _$CalendarStateCopyWith(_CalendarState value, $Res Function(_CalendarState) _then) = __$CalendarStateCopyWithImpl;
@override @useResult
$Res call({
 int year, int month, Map<int, ShiftType> assignments, bool paintMode, ShiftType? selectedShiftType, SubmissionStatus submissionStatus, List<ShiftType> shiftTypes
});


@override $ShiftTypeCopyWith<$Res>? get selectedShiftType;

}
/// @nodoc
class __$CalendarStateCopyWithImpl<$Res>
    implements _$CalendarStateCopyWith<$Res> {
  __$CalendarStateCopyWithImpl(this._self, this._then);

  final _CalendarState _self;
  final $Res Function(_CalendarState) _then;

/// Create a copy of CalendarState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? year = null,Object? month = null,Object? assignments = null,Object? paintMode = null,Object? selectedShiftType = freezed,Object? submissionStatus = null,Object? shiftTypes = null,}) {
  return _then(_CalendarState(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,assignments: null == assignments ? _self._assignments : assignments // ignore: cast_nullable_to_non_nullable
as Map<int, ShiftType>,paintMode: null == paintMode ? _self.paintMode : paintMode // ignore: cast_nullable_to_non_nullable
as bool,selectedShiftType: freezed == selectedShiftType ? _self.selectedShiftType : selectedShiftType // ignore: cast_nullable_to_non_nullable
as ShiftType?,submissionStatus: null == submissionStatus ? _self.submissionStatus : submissionStatus // ignore: cast_nullable_to_non_nullable
as SubmissionStatus,shiftTypes: null == shiftTypes ? _self._shiftTypes : shiftTypes // ignore: cast_nullable_to_non_nullable
as List<ShiftType>,
  ));
}

/// Create a copy of CalendarState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShiftTypeCopyWith<$Res>? get selectedShiftType {
    if (_self.selectedShiftType == null) {
    return null;
  }

  return $ShiftTypeCopyWith<$Res>(_self.selectedShiftType!, (value) {
    return _then(_self.copyWith(selectedShiftType: value));
  });
}
}

// dart format on
