// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'manager_calendar_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TeamMember {

 String get id; String get name; SubmissionStatus get status; int get filledPercent; Map<int, ShiftType> get assignments;
/// Create a copy of TeamMember
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeamMemberCopyWith<TeamMember> get copyWith => _$TeamMemberCopyWithImpl<TeamMember>(this as TeamMember, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamMember&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.status, status) || other.status == status)&&(identical(other.filledPercent, filledPercent) || other.filledPercent == filledPercent)&&const DeepCollectionEquality().equals(other.assignments, assignments));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,status,filledPercent,const DeepCollectionEquality().hash(assignments));

@override
String toString() {
  return 'TeamMember(id: $id, name: $name, status: $status, filledPercent: $filledPercent, assignments: $assignments)';
}


}

/// @nodoc
abstract mixin class $TeamMemberCopyWith<$Res>  {
  factory $TeamMemberCopyWith(TeamMember value, $Res Function(TeamMember) _then) = _$TeamMemberCopyWithImpl;
@useResult
$Res call({
 String id, String name, SubmissionStatus status, int filledPercent, Map<int, ShiftType> assignments
});




}
/// @nodoc
class _$TeamMemberCopyWithImpl<$Res>
    implements $TeamMemberCopyWith<$Res> {
  _$TeamMemberCopyWithImpl(this._self, this._then);

  final TeamMember _self;
  final $Res Function(TeamMember) _then;

/// Create a copy of TeamMember
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? status = null,Object? filledPercent = null,Object? assignments = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SubmissionStatus,filledPercent: null == filledPercent ? _self.filledPercent : filledPercent // ignore: cast_nullable_to_non_nullable
as int,assignments: null == assignments ? _self.assignments : assignments // ignore: cast_nullable_to_non_nullable
as Map<int, ShiftType>,
  ));
}

}


/// Adds pattern-matching-related methods to [TeamMember].
extension TeamMemberPatterns on TeamMember {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TeamMember value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TeamMember() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TeamMember value)  $default,){
final _that = this;
switch (_that) {
case _TeamMember():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TeamMember value)?  $default,){
final _that = this;
switch (_that) {
case _TeamMember() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  SubmissionStatus status,  int filledPercent,  Map<int, ShiftType> assignments)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TeamMember() when $default != null:
return $default(_that.id,_that.name,_that.status,_that.filledPercent,_that.assignments);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  SubmissionStatus status,  int filledPercent,  Map<int, ShiftType> assignments)  $default,) {final _that = this;
switch (_that) {
case _TeamMember():
return $default(_that.id,_that.name,_that.status,_that.filledPercent,_that.assignments);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  SubmissionStatus status,  int filledPercent,  Map<int, ShiftType> assignments)?  $default,) {final _that = this;
switch (_that) {
case _TeamMember() when $default != null:
return $default(_that.id,_that.name,_that.status,_that.filledPercent,_that.assignments);case _:
  return null;

}
}

}

/// @nodoc


class _TeamMember implements TeamMember {
  const _TeamMember({required this.id, required this.name, required this.status, this.filledPercent = 0, final  Map<int, ShiftType> assignments = const {}}): _assignments = assignments;
  

@override final  String id;
@override final  String name;
@override final  SubmissionStatus status;
@override@JsonKey() final  int filledPercent;
 final  Map<int, ShiftType> _assignments;
@override@JsonKey() Map<int, ShiftType> get assignments {
  if (_assignments is EqualUnmodifiableMapView) return _assignments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_assignments);
}


/// Create a copy of TeamMember
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TeamMemberCopyWith<_TeamMember> get copyWith => __$TeamMemberCopyWithImpl<_TeamMember>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TeamMember&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.status, status) || other.status == status)&&(identical(other.filledPercent, filledPercent) || other.filledPercent == filledPercent)&&const DeepCollectionEquality().equals(other._assignments, _assignments));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,status,filledPercent,const DeepCollectionEquality().hash(_assignments));

@override
String toString() {
  return 'TeamMember(id: $id, name: $name, status: $status, filledPercent: $filledPercent, assignments: $assignments)';
}


}

/// @nodoc
abstract mixin class _$TeamMemberCopyWith<$Res> implements $TeamMemberCopyWith<$Res> {
  factory _$TeamMemberCopyWith(_TeamMember value, $Res Function(_TeamMember) _then) = __$TeamMemberCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, SubmissionStatus status, int filledPercent, Map<int, ShiftType> assignments
});




}
/// @nodoc
class __$TeamMemberCopyWithImpl<$Res>
    implements _$TeamMemberCopyWith<$Res> {
  __$TeamMemberCopyWithImpl(this._self, this._then);

  final _TeamMember _self;
  final $Res Function(_TeamMember) _then;

/// Create a copy of TeamMember
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? status = null,Object? filledPercent = null,Object? assignments = null,}) {
  return _then(_TeamMember(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SubmissionStatus,filledPercent: null == filledPercent ? _self.filledPercent : filledPercent // ignore: cast_nullable_to_non_nullable
as int,assignments: null == assignments ? _self._assignments : assignments // ignore: cast_nullable_to_non_nullable
as Map<int, ShiftType>,
  ));
}


}

/// @nodoc
mixin _$ManagerCalendarState {

 int get year; int get month; List<CalendarEvent> get events; List<TeamMember> get teamMembers; int get defaultVacationMax; Map<int, int> get vacationOverrides; Map<int, int> get vacationCounts;
/// Create a copy of ManagerCalendarState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ManagerCalendarStateCopyWith<ManagerCalendarState> get copyWith => _$ManagerCalendarStateCopyWithImpl<ManagerCalendarState>(this as ManagerCalendarState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ManagerCalendarState&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&const DeepCollectionEquality().equals(other.events, events)&&const DeepCollectionEquality().equals(other.teamMembers, teamMembers)&&(identical(other.defaultVacationMax, defaultVacationMax) || other.defaultVacationMax == defaultVacationMax)&&const DeepCollectionEquality().equals(other.vacationOverrides, vacationOverrides)&&const DeepCollectionEquality().equals(other.vacationCounts, vacationCounts));
}


@override
int get hashCode => Object.hash(runtimeType,year,month,const DeepCollectionEquality().hash(events),const DeepCollectionEquality().hash(teamMembers),defaultVacationMax,const DeepCollectionEquality().hash(vacationOverrides),const DeepCollectionEquality().hash(vacationCounts));

@override
String toString() {
  return 'ManagerCalendarState(year: $year, month: $month, events: $events, teamMembers: $teamMembers, defaultVacationMax: $defaultVacationMax, vacationOverrides: $vacationOverrides, vacationCounts: $vacationCounts)';
}


}

/// @nodoc
abstract mixin class $ManagerCalendarStateCopyWith<$Res>  {
  factory $ManagerCalendarStateCopyWith(ManagerCalendarState value, $Res Function(ManagerCalendarState) _then) = _$ManagerCalendarStateCopyWithImpl;
@useResult
$Res call({
 int year, int month, List<CalendarEvent> events, List<TeamMember> teamMembers, int defaultVacationMax, Map<int, int> vacationOverrides, Map<int, int> vacationCounts
});




}
/// @nodoc
class _$ManagerCalendarStateCopyWithImpl<$Res>
    implements $ManagerCalendarStateCopyWith<$Res> {
  _$ManagerCalendarStateCopyWithImpl(this._self, this._then);

  final ManagerCalendarState _self;
  final $Res Function(ManagerCalendarState) _then;

/// Create a copy of ManagerCalendarState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? year = null,Object? month = null,Object? events = null,Object? teamMembers = null,Object? defaultVacationMax = null,Object? vacationOverrides = null,Object? vacationCounts = null,}) {
  return _then(_self.copyWith(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as List<CalendarEvent>,teamMembers: null == teamMembers ? _self.teamMembers : teamMembers // ignore: cast_nullable_to_non_nullable
as List<TeamMember>,defaultVacationMax: null == defaultVacationMax ? _self.defaultVacationMax : defaultVacationMax // ignore: cast_nullable_to_non_nullable
as int,vacationOverrides: null == vacationOverrides ? _self.vacationOverrides : vacationOverrides // ignore: cast_nullable_to_non_nullable
as Map<int, int>,vacationCounts: null == vacationCounts ? _self.vacationCounts : vacationCounts // ignore: cast_nullable_to_non_nullable
as Map<int, int>,
  ));
}

}


/// Adds pattern-matching-related methods to [ManagerCalendarState].
extension ManagerCalendarStatePatterns on ManagerCalendarState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ManagerCalendarState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ManagerCalendarState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ManagerCalendarState value)  $default,){
final _that = this;
switch (_that) {
case _ManagerCalendarState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ManagerCalendarState value)?  $default,){
final _that = this;
switch (_that) {
case _ManagerCalendarState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int year,  int month,  List<CalendarEvent> events,  List<TeamMember> teamMembers,  int defaultVacationMax,  Map<int, int> vacationOverrides,  Map<int, int> vacationCounts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ManagerCalendarState() when $default != null:
return $default(_that.year,_that.month,_that.events,_that.teamMembers,_that.defaultVacationMax,_that.vacationOverrides,_that.vacationCounts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int year,  int month,  List<CalendarEvent> events,  List<TeamMember> teamMembers,  int defaultVacationMax,  Map<int, int> vacationOverrides,  Map<int, int> vacationCounts)  $default,) {final _that = this;
switch (_that) {
case _ManagerCalendarState():
return $default(_that.year,_that.month,_that.events,_that.teamMembers,_that.defaultVacationMax,_that.vacationOverrides,_that.vacationCounts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int year,  int month,  List<CalendarEvent> events,  List<TeamMember> teamMembers,  int defaultVacationMax,  Map<int, int> vacationOverrides,  Map<int, int> vacationCounts)?  $default,) {final _that = this;
switch (_that) {
case _ManagerCalendarState() when $default != null:
return $default(_that.year,_that.month,_that.events,_that.teamMembers,_that.defaultVacationMax,_that.vacationOverrides,_that.vacationCounts);case _:
  return null;

}
}

}

/// @nodoc


class _ManagerCalendarState extends ManagerCalendarState {
  const _ManagerCalendarState({required this.year, required this.month, final  List<CalendarEvent> events = const [], final  List<TeamMember> teamMembers = const [], this.defaultVacationMax = 3, final  Map<int, int> vacationOverrides = const {}, final  Map<int, int> vacationCounts = const {}}): _events = events,_teamMembers = teamMembers,_vacationOverrides = vacationOverrides,_vacationCounts = vacationCounts,super._();
  

@override final  int year;
@override final  int month;
 final  List<CalendarEvent> _events;
@override@JsonKey() List<CalendarEvent> get events {
  if (_events is EqualUnmodifiableListView) return _events;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_events);
}

 final  List<TeamMember> _teamMembers;
@override@JsonKey() List<TeamMember> get teamMembers {
  if (_teamMembers is EqualUnmodifiableListView) return _teamMembers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_teamMembers);
}

@override@JsonKey() final  int defaultVacationMax;
 final  Map<int, int> _vacationOverrides;
@override@JsonKey() Map<int, int> get vacationOverrides {
  if (_vacationOverrides is EqualUnmodifiableMapView) return _vacationOverrides;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_vacationOverrides);
}

 final  Map<int, int> _vacationCounts;
@override@JsonKey() Map<int, int> get vacationCounts {
  if (_vacationCounts is EqualUnmodifiableMapView) return _vacationCounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_vacationCounts);
}


/// Create a copy of ManagerCalendarState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ManagerCalendarStateCopyWith<_ManagerCalendarState> get copyWith => __$ManagerCalendarStateCopyWithImpl<_ManagerCalendarState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ManagerCalendarState&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&const DeepCollectionEquality().equals(other._events, _events)&&const DeepCollectionEquality().equals(other._teamMembers, _teamMembers)&&(identical(other.defaultVacationMax, defaultVacationMax) || other.defaultVacationMax == defaultVacationMax)&&const DeepCollectionEquality().equals(other._vacationOverrides, _vacationOverrides)&&const DeepCollectionEquality().equals(other._vacationCounts, _vacationCounts));
}


@override
int get hashCode => Object.hash(runtimeType,year,month,const DeepCollectionEquality().hash(_events),const DeepCollectionEquality().hash(_teamMembers),defaultVacationMax,const DeepCollectionEquality().hash(_vacationOverrides),const DeepCollectionEquality().hash(_vacationCounts));

@override
String toString() {
  return 'ManagerCalendarState(year: $year, month: $month, events: $events, teamMembers: $teamMembers, defaultVacationMax: $defaultVacationMax, vacationOverrides: $vacationOverrides, vacationCounts: $vacationCounts)';
}


}

/// @nodoc
abstract mixin class _$ManagerCalendarStateCopyWith<$Res> implements $ManagerCalendarStateCopyWith<$Res> {
  factory _$ManagerCalendarStateCopyWith(_ManagerCalendarState value, $Res Function(_ManagerCalendarState) _then) = __$ManagerCalendarStateCopyWithImpl;
@override @useResult
$Res call({
 int year, int month, List<CalendarEvent> events, List<TeamMember> teamMembers, int defaultVacationMax, Map<int, int> vacationOverrides, Map<int, int> vacationCounts
});




}
/// @nodoc
class __$ManagerCalendarStateCopyWithImpl<$Res>
    implements _$ManagerCalendarStateCopyWith<$Res> {
  __$ManagerCalendarStateCopyWithImpl(this._self, this._then);

  final _ManagerCalendarState _self;
  final $Res Function(_ManagerCalendarState) _then;

/// Create a copy of ManagerCalendarState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? year = null,Object? month = null,Object? events = null,Object? teamMembers = null,Object? defaultVacationMax = null,Object? vacationOverrides = null,Object? vacationCounts = null,}) {
  return _then(_ManagerCalendarState(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,events: null == events ? _self._events : events // ignore: cast_nullable_to_non_nullable
as List<CalendarEvent>,teamMembers: null == teamMembers ? _self._teamMembers : teamMembers // ignore: cast_nullable_to_non_nullable
as List<TeamMember>,defaultVacationMax: null == defaultVacationMax ? _self.defaultVacationMax : defaultVacationMax // ignore: cast_nullable_to_non_nullable
as int,vacationOverrides: null == vacationOverrides ? _self._vacationOverrides : vacationOverrides // ignore: cast_nullable_to_non_nullable
as Map<int, int>,vacationCounts: null == vacationCounts ? _self._vacationCounts : vacationCounts // ignore: cast_nullable_to_non_nullable
as Map<int, int>,
  ));
}


}

// dart format on
