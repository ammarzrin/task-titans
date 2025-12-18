// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reward.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reward _$RewardFromJson(Map<String, dynamic> json) => Reward(
  id: json['id'] as String,
  familyId: json['family_id'] as String,
  title: json['title'] as String,
  cost: (json['cost'] as num).toInt(),
  iconId: json['icon_id'] as String,
  stock: (json['stock'] as num?)?.toInt(),
);

Map<String, dynamic> _$RewardToJson(Reward instance) => <String, dynamic>{
  'id': instance.id,
  'family_id': instance.familyId,
  'title': instance.title,
  'cost': instance.cost,
  'icon_id': instance.iconId,
  'stock': instance.stock,
};
