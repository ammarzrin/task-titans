// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mission.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mission _$MissionFromJson(Map<String, dynamic> json) => Mission(
  id: json['id'] as String,
  familyId: json['family_id'] as String,
  title: json['title'] as String,
  difficulty: $enumDecode(_$MissionDifficultyEnumMap, json['difficulty']),
  iconId: json['icon_id'] as String,
  assignedTo: json['assigned_to'] as String?,
  status: $enumDecode(_$MissionStatusEnumMap, json['status']),
  xpReward: (json['xp_reward'] as num).toInt(),
  goldReward: (json['gold_reward'] as num).toInt(),
  createdBy: json['created_by'] as String,
);

Map<String, dynamic> _$MissionToJson(Mission instance) => <String, dynamic>{
  'id': instance.id,
  'family_id': instance.familyId,
  'title': instance.title,
  'difficulty': _$MissionDifficultyEnumMap[instance.difficulty]!,
  'icon_id': instance.iconId,
  'assigned_to': instance.assignedTo,
  'status': _$MissionStatusEnumMap[instance.status]!,
  'xp_reward': instance.xpReward,
  'gold_reward': instance.goldReward,
  'created_by': instance.createdBy,
};

const _$MissionDifficultyEnumMap = {
  MissionDifficulty.easy: 'easy',
  MissionDifficulty.medium: 'medium',
  MissionDifficulty.hard: 'hard',
  MissionDifficulty.epic: 'epic',
};

const _$MissionStatusEnumMap = {
  MissionStatus.available: 'available',
  MissionStatus.inProgress: 'in_progress',
  MissionStatus.pendingApproval: 'pending_approval',
  MissionStatus.completed: 'completed',
};
