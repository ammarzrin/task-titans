// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Family _$FamilyFromJson(Map<String, dynamic> json) => Family(
  id: json['id'] as String,
  name: json['name'] as String,
  inviteCode: json['invite_code'] as String,
);

Map<String, dynamic> _$FamilyToJson(Family instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'invite_code': instance.inviteCode,
};
