// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vacation_settings_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VacationSettingsState {

 int get defaultMax; Map<int, int> get overrides;
/// Create a copy of VacationSettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VacationSettingsStateCopyWith<VacationSettingsState> get copyWith => _$VacationSettingsStateCopyWithImpl<VacationSettingsState>(this as VacationSettingsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VacationSettingsState&&(identical(other.defaultMax, defaultMax) || other.defaultMax == defaultMax)&&const DeepCollectionEquality().equals(other.overrides, overrides));
}


@override
int get hashCode => Object.hash(runtimeType,defaultMax,const DeepCollectionEquality().hash(overrides));

@override
String toString() {
  return 'VacationSettingsState(defaultMax: $defaultMax, overrides: $overrides)';
}


}

/// @nodoc
abstract mixin class $VacationSettingsStateCopyWith<$Res>  {
  factory $VacationSettingsStateCopyWith(VacationSettingsState value, $Res Function(VacationSettingsState) _then) = _$VacationSettingsStateCopyWithImpl;
@useResult
$Res call({
 int defaultMax, Map<int, int> overrides
});




}
/// @nodoc
class _$VacationSettingsStateCopyWithImpl<$Res>
    implements $VacationSettingsStateCopyWith<$Res> {
  _$VacationSettingsStateCopyWithImpl(this._self, this._then);

  final VacationSettingsState _self;
  final $Res Function(VacationSettingsState) _then;

/// Create a copy of VacationSettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? defaultMax = null,Object? overrides = null,}) {
  return _then(_self.copyWith(
defaultMax: null == defaultMax ? _self.defaultMax : defaultMax // ignore: cast_nullable_to_non_nullable
as int,overrides: null == overrides ? _self.overrides : overrides // ignore: cast_nullable_to_non_nullable
as Map<int, int>,
  ));
}

}


/// Adds pattern-matching-related methods to [VacationSettingsState].
extension VacationSettingsStatePatterns on VacationSettingsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VacationSettingsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VacationSettingsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VacationSettingsState value)  $default,){
final _that = this;
switch (_that) {
case _VacationSettingsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VacationSettingsState value)?  $default,){
final _that = this;
switch (_that) {
case _VacationSettingsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int defaultMax,  Map<int, int> overrides)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VacationSettingsState() when $default != null:
return $default(_that.defaultMax,_that.overrides);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int defaultMax,  Map<int, int> overrides)  $default,) {final _that = this;
switch (_that) {
case _VacationSettingsState():
return $default(_that.defaultMax,_that.overrides);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int defaultMax,  Map<int, int> overrides)?  $default,) {final _that = this;
switch (_that) {
case _VacationSettingsState() when $default != null:
return $default(_that.defaultMax,_that.overrides);case _:
  return null;

}
}

}

/// @nodoc


class _VacationSettingsState implements VacationSettingsState {
  const _VacationSettingsState({this.defaultMax = 3, final  Map<int, int> overrides = const {}}): _overrides = overrides;
  

@override@JsonKey() final  int defaultMax;
 final  Map<int, int> _overrides;
@override@JsonKey() Map<int, int> get overrides {
  if (_overrides is EqualUnmodifiableMapView) return _overrides;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_overrides);
}


/// Create a copy of VacationSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VacationSettingsStateCopyWith<_VacationSettingsState> get copyWith => __$VacationSettingsStateCopyWithImpl<_VacationSettingsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VacationSettingsState&&(identical(other.defaultMax, defaultMax) || other.defaultMax == defaultMax)&&const DeepCollectionEquality().equals(other._overrides, _overrides));
}


@override
int get hashCode => Object.hash(runtimeType,defaultMax,const DeepCollectionEquality().hash(_overrides));

@override
String toString() {
  return 'VacationSettingsState(defaultMax: $defaultMax, overrides: $overrides)';
}


}

/// @nodoc
abstract mixin class _$VacationSettingsStateCopyWith<$Res> implements $VacationSettingsStateCopyWith<$Res> {
  factory _$VacationSettingsStateCopyWith(_VacationSettingsState value, $Res Function(_VacationSettingsState) _then) = __$VacationSettingsStateCopyWithImpl;
@override @useResult
$Res call({
 int defaultMax, Map<int, int> overrides
});




}
/// @nodoc
class __$VacationSettingsStateCopyWithImpl<$Res>
    implements _$VacationSettingsStateCopyWith<$Res> {
  __$VacationSettingsStateCopyWithImpl(this._self, this._then);

  final _VacationSettingsState _self;
  final $Res Function(_VacationSettingsState) _then;

/// Create a copy of VacationSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? defaultMax = null,Object? overrides = null,}) {
  return _then(_VacationSettingsState(
defaultMax: null == defaultMax ? _self.defaultMax : defaultMax // ignore: cast_nullable_to_non_nullable
as int,overrides: null == overrides ? _self._overrides : overrides // ignore: cast_nullable_to_non_nullable
as Map<int, int>,
  ));
}


}

// dart format on
