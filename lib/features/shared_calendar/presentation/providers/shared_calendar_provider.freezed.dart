// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shared_calendar_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MemberWeekRow {

 String get userId; String get userName; String? get profileImageUrl; Map<int, ShiftType> get assignments;
/// Create a copy of MemberWeekRow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberWeekRowCopyWith<MemberWeekRow> get copyWith => _$MemberWeekRowCopyWithImpl<MemberWeekRow>(this as MemberWeekRow, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberWeekRow&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.profileImageUrl, profileImageUrl) || other.profileImageUrl == profileImageUrl)&&const DeepCollectionEquality().equals(other.assignments, assignments));
}


@override
int get hashCode => Object.hash(runtimeType,userId,userName,profileImageUrl,const DeepCollectionEquality().hash(assignments));

@override
String toString() {
  return 'MemberWeekRow(userId: $userId, userName: $userName, profileImageUrl: $profileImageUrl, assignments: $assignments)';
}


}

/// @nodoc
abstract mixin class $MemberWeekRowCopyWith<$Res>  {
  factory $MemberWeekRowCopyWith(MemberWeekRow value, $Res Function(MemberWeekRow) _then) = _$MemberWeekRowCopyWithImpl;
@useResult
$Res call({
 String userId, String userName, String? profileImageUrl, Map<int, ShiftType> assignments
});




}
/// @nodoc
class _$MemberWeekRowCopyWithImpl<$Res>
    implements $MemberWeekRowCopyWith<$Res> {
  _$MemberWeekRowCopyWithImpl(this._self, this._then);

  final MemberWeekRow _self;
  final $Res Function(MemberWeekRow) _then;

/// Create a copy of MemberWeekRow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? userName = null,Object? profileImageUrl = freezed,Object? assignments = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,profileImageUrl: freezed == profileImageUrl ? _self.profileImageUrl : profileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,assignments: null == assignments ? _self.assignments : assignments // ignore: cast_nullable_to_non_nullable
as Map<int, ShiftType>,
  ));
}

}


/// Adds pattern-matching-related methods to [MemberWeekRow].
extension MemberWeekRowPatterns on MemberWeekRow {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemberWeekRow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemberWeekRow() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemberWeekRow value)  $default,){
final _that = this;
switch (_that) {
case _MemberWeekRow():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemberWeekRow value)?  $default,){
final _that = this;
switch (_that) {
case _MemberWeekRow() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String userName,  String? profileImageUrl,  Map<int, ShiftType> assignments)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemberWeekRow() when $default != null:
return $default(_that.userId,_that.userName,_that.profileImageUrl,_that.assignments);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String userName,  String? profileImageUrl,  Map<int, ShiftType> assignments)  $default,) {final _that = this;
switch (_that) {
case _MemberWeekRow():
return $default(_that.userId,_that.userName,_that.profileImageUrl,_that.assignments);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String userName,  String? profileImageUrl,  Map<int, ShiftType> assignments)?  $default,) {final _that = this;
switch (_that) {
case _MemberWeekRow() when $default != null:
return $default(_that.userId,_that.userName,_that.profileImageUrl,_that.assignments);case _:
  return null;

}
}

}

/// @nodoc


class _MemberWeekRow implements MemberWeekRow {
  const _MemberWeekRow({required this.userId, required this.userName, this.profileImageUrl, final  Map<int, ShiftType> assignments = const {}}): _assignments = assignments;
  

@override final  String userId;
@override final  String userName;
@override final  String? profileImageUrl;
 final  Map<int, ShiftType> _assignments;
@override@JsonKey() Map<int, ShiftType> get assignments {
  if (_assignments is EqualUnmodifiableMapView) return _assignments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_assignments);
}


/// Create a copy of MemberWeekRow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberWeekRowCopyWith<_MemberWeekRow> get copyWith => __$MemberWeekRowCopyWithImpl<_MemberWeekRow>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberWeekRow&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.profileImageUrl, profileImageUrl) || other.profileImageUrl == profileImageUrl)&&const DeepCollectionEquality().equals(other._assignments, _assignments));
}


@override
int get hashCode => Object.hash(runtimeType,userId,userName,profileImageUrl,const DeepCollectionEquality().hash(_assignments));

@override
String toString() {
  return 'MemberWeekRow(userId: $userId, userName: $userName, profileImageUrl: $profileImageUrl, assignments: $assignments)';
}


}

/// @nodoc
abstract mixin class _$MemberWeekRowCopyWith<$Res> implements $MemberWeekRowCopyWith<$Res> {
  factory _$MemberWeekRowCopyWith(_MemberWeekRow value, $Res Function(_MemberWeekRow) _then) = __$MemberWeekRowCopyWithImpl;
@override @useResult
$Res call({
 String userId, String userName, String? profileImageUrl, Map<int, ShiftType> assignments
});




}
/// @nodoc
class __$MemberWeekRowCopyWithImpl<$Res>
    implements _$MemberWeekRowCopyWith<$Res> {
  __$MemberWeekRowCopyWithImpl(this._self, this._then);

  final _MemberWeekRow _self;
  final $Res Function(_MemberWeekRow) _then;

/// Create a copy of MemberWeekRow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? userName = null,Object? profileImageUrl = freezed,Object? assignments = null,}) {
  return _then(_MemberWeekRow(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,profileImageUrl: freezed == profileImageUrl ? _self.profileImageUrl : profileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,assignments: null == assignments ? _self._assignments : assignments // ignore: cast_nullable_to_non_nullable
as Map<int, ShiftType>,
  ));
}


}

/// @nodoc
mixin _$SharedCalendarState {

 int get year; int get month; CalendarViewMode get viewMode; Map<int, DayShiftSummary> get daySummaries; List<MemberWeekRow> get weekMembers; List<CalendarEvent> get events; int get selectedWeekStartDay; bool get isLoading;
/// Create a copy of SharedCalendarState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SharedCalendarStateCopyWith<SharedCalendarState> get copyWith => _$SharedCalendarStateCopyWithImpl<SharedCalendarState>(this as SharedCalendarState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SharedCalendarState&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.viewMode, viewMode) || other.viewMode == viewMode)&&const DeepCollectionEquality().equals(other.daySummaries, daySummaries)&&const DeepCollectionEquality().equals(other.weekMembers, weekMembers)&&const DeepCollectionEquality().equals(other.events, events)&&(identical(other.selectedWeekStartDay, selectedWeekStartDay) || other.selectedWeekStartDay == selectedWeekStartDay)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,year,month,viewMode,const DeepCollectionEquality().hash(daySummaries),const DeepCollectionEquality().hash(weekMembers),const DeepCollectionEquality().hash(events),selectedWeekStartDay,isLoading);

@override
String toString() {
  return 'SharedCalendarState(year: $year, month: $month, viewMode: $viewMode, daySummaries: $daySummaries, weekMembers: $weekMembers, events: $events, selectedWeekStartDay: $selectedWeekStartDay, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class $SharedCalendarStateCopyWith<$Res>  {
  factory $SharedCalendarStateCopyWith(SharedCalendarState value, $Res Function(SharedCalendarState) _then) = _$SharedCalendarStateCopyWithImpl;
@useResult
$Res call({
 int year, int month, CalendarViewMode viewMode, Map<int, DayShiftSummary> daySummaries, List<MemberWeekRow> weekMembers, List<CalendarEvent> events, int selectedWeekStartDay, bool isLoading
});




}
/// @nodoc
class _$SharedCalendarStateCopyWithImpl<$Res>
    implements $SharedCalendarStateCopyWith<$Res> {
  _$SharedCalendarStateCopyWithImpl(this._self, this._then);

  final SharedCalendarState _self;
  final $Res Function(SharedCalendarState) _then;

/// Create a copy of SharedCalendarState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? year = null,Object? month = null,Object? viewMode = null,Object? daySummaries = null,Object? weekMembers = null,Object? events = null,Object? selectedWeekStartDay = null,Object? isLoading = null,}) {
  return _then(_self.copyWith(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,viewMode: null == viewMode ? _self.viewMode : viewMode // ignore: cast_nullable_to_non_nullable
as CalendarViewMode,daySummaries: null == daySummaries ? _self.daySummaries : daySummaries // ignore: cast_nullable_to_non_nullable
as Map<int, DayShiftSummary>,weekMembers: null == weekMembers ? _self.weekMembers : weekMembers // ignore: cast_nullable_to_non_nullable
as List<MemberWeekRow>,events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as List<CalendarEvent>,selectedWeekStartDay: null == selectedWeekStartDay ? _self.selectedWeekStartDay : selectedWeekStartDay // ignore: cast_nullable_to_non_nullable
as int,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SharedCalendarState].
extension SharedCalendarStatePatterns on SharedCalendarState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SharedCalendarState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SharedCalendarState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SharedCalendarState value)  $default,){
final _that = this;
switch (_that) {
case _SharedCalendarState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SharedCalendarState value)?  $default,){
final _that = this;
switch (_that) {
case _SharedCalendarState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int year,  int month,  CalendarViewMode viewMode,  Map<int, DayShiftSummary> daySummaries,  List<MemberWeekRow> weekMembers,  List<CalendarEvent> events,  int selectedWeekStartDay,  bool isLoading)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SharedCalendarState() when $default != null:
return $default(_that.year,_that.month,_that.viewMode,_that.daySummaries,_that.weekMembers,_that.events,_that.selectedWeekStartDay,_that.isLoading);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int year,  int month,  CalendarViewMode viewMode,  Map<int, DayShiftSummary> daySummaries,  List<MemberWeekRow> weekMembers,  List<CalendarEvent> events,  int selectedWeekStartDay,  bool isLoading)  $default,) {final _that = this;
switch (_that) {
case _SharedCalendarState():
return $default(_that.year,_that.month,_that.viewMode,_that.daySummaries,_that.weekMembers,_that.events,_that.selectedWeekStartDay,_that.isLoading);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int year,  int month,  CalendarViewMode viewMode,  Map<int, DayShiftSummary> daySummaries,  List<MemberWeekRow> weekMembers,  List<CalendarEvent> events,  int selectedWeekStartDay,  bool isLoading)?  $default,) {final _that = this;
switch (_that) {
case _SharedCalendarState() when $default != null:
return $default(_that.year,_that.month,_that.viewMode,_that.daySummaries,_that.weekMembers,_that.events,_that.selectedWeekStartDay,_that.isLoading);case _:
  return null;

}
}

}

/// @nodoc


class _SharedCalendarState implements SharedCalendarState {
  const _SharedCalendarState({required this.year, required this.month, this.viewMode = CalendarViewMode.monthly, final  Map<int, DayShiftSummary> daySummaries = const {}, final  List<MemberWeekRow> weekMembers = const [], final  List<CalendarEvent> events = const [], this.selectedWeekStartDay = 1, this.isLoading = false}): _daySummaries = daySummaries,_weekMembers = weekMembers,_events = events;
  

@override final  int year;
@override final  int month;
@override@JsonKey() final  CalendarViewMode viewMode;
 final  Map<int, DayShiftSummary> _daySummaries;
@override@JsonKey() Map<int, DayShiftSummary> get daySummaries {
  if (_daySummaries is EqualUnmodifiableMapView) return _daySummaries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_daySummaries);
}

 final  List<MemberWeekRow> _weekMembers;
@override@JsonKey() List<MemberWeekRow> get weekMembers {
  if (_weekMembers is EqualUnmodifiableListView) return _weekMembers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weekMembers);
}

 final  List<CalendarEvent> _events;
@override@JsonKey() List<CalendarEvent> get events {
  if (_events is EqualUnmodifiableListView) return _events;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_events);
}

@override@JsonKey() final  int selectedWeekStartDay;
@override@JsonKey() final  bool isLoading;

/// Create a copy of SharedCalendarState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SharedCalendarStateCopyWith<_SharedCalendarState> get copyWith => __$SharedCalendarStateCopyWithImpl<_SharedCalendarState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SharedCalendarState&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.viewMode, viewMode) || other.viewMode == viewMode)&&const DeepCollectionEquality().equals(other._daySummaries, _daySummaries)&&const DeepCollectionEquality().equals(other._weekMembers, _weekMembers)&&const DeepCollectionEquality().equals(other._events, _events)&&(identical(other.selectedWeekStartDay, selectedWeekStartDay) || other.selectedWeekStartDay == selectedWeekStartDay)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,year,month,viewMode,const DeepCollectionEquality().hash(_daySummaries),const DeepCollectionEquality().hash(_weekMembers),const DeepCollectionEquality().hash(_events),selectedWeekStartDay,isLoading);

@override
String toString() {
  return 'SharedCalendarState(year: $year, month: $month, viewMode: $viewMode, daySummaries: $daySummaries, weekMembers: $weekMembers, events: $events, selectedWeekStartDay: $selectedWeekStartDay, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class _$SharedCalendarStateCopyWith<$Res> implements $SharedCalendarStateCopyWith<$Res> {
  factory _$SharedCalendarStateCopyWith(_SharedCalendarState value, $Res Function(_SharedCalendarState) _then) = __$SharedCalendarStateCopyWithImpl;
@override @useResult
$Res call({
 int year, int month, CalendarViewMode viewMode, Map<int, DayShiftSummary> daySummaries, List<MemberWeekRow> weekMembers, List<CalendarEvent> events, int selectedWeekStartDay, bool isLoading
});




}
/// @nodoc
class __$SharedCalendarStateCopyWithImpl<$Res>
    implements _$SharedCalendarStateCopyWith<$Res> {
  __$SharedCalendarStateCopyWithImpl(this._self, this._then);

  final _SharedCalendarState _self;
  final $Res Function(_SharedCalendarState) _then;

/// Create a copy of SharedCalendarState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? year = null,Object? month = null,Object? viewMode = null,Object? daySummaries = null,Object? weekMembers = null,Object? events = null,Object? selectedWeekStartDay = null,Object? isLoading = null,}) {
  return _then(_SharedCalendarState(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,viewMode: null == viewMode ? _self.viewMode : viewMode // ignore: cast_nullable_to_non_nullable
as CalendarViewMode,daySummaries: null == daySummaries ? _self._daySummaries : daySummaries // ignore: cast_nullable_to_non_nullable
as Map<int, DayShiftSummary>,weekMembers: null == weekMembers ? _self._weekMembers : weekMembers // ignore: cast_nullable_to_non_nullable
as List<MemberWeekRow>,events: null == events ? _self._events : events // ignore: cast_nullable_to_non_nullable
as List<CalendarEvent>,selectedWeekStartDay: null == selectedWeekStartDay ? _self.selectedWeekStartDay : selectedWeekStartDay // ignore: cast_nullable_to_non_nullable
as int,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
