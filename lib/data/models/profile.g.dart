// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
  id: json['id'] as String,
  familyId: json['family_id'] as String,
  role: $enumDecode(_$UserRoleEnumMap, json['role']),
  username: json['username'] as String,
  avatarId: json['avatar_id'] as String,
  pinCode: json['pin_code'] as String,
  xp: (json['xp'] as num?)?.toInt(),
  gold: (json['gold'] as num?)?.toInt(),
  level: (json['level'] as num?)?.toInt(),
);

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
  'id': instance.id,
  'family_id': instance.familyId,
  'role': _$UserRoleEnumMap[instance.role]!,
  'username': instance.username,
  'avatar_id': instance.avatarId,
  'pin_code': instance.pinCode,
  'xp': instance.xp,
  'gold': instance.gold,
  'level': instance.level,
};

const _$UserRoleEnumMap = {UserRole.parent: 'parent', UserRole.child: 'child'};
