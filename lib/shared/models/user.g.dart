// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppUser _$AppUserFromJson(Map<String, dynamic> json) => _AppUser(
  id: json['id'] as String,
  email: json['email'] as String,
  name: json['name'] as String,
  profileImageUrl: json['profileImageUrl'] as String?,
  role: json['role'] as String,
  branchId: json['branchId'] as String?,
  branchName: json['branchName'] as String?,
);

Map<String, dynamic> _$AppUserToJson(_AppUser instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'name': instance.name,
  'profileImageUrl': instance.profileImageUrl,
  'role': instance.role,
  'branchId': instance.branchId,
  'branchName': instance.branchName,
};
