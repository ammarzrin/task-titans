import 'package:json_annotation/json_annotation.dart';

part 'mission.g.dart';

enum MissionDifficulty {
  easy,
  medium,
  hard,
  epic,
}

enum MissionStatus {
  available,
  @JsonValue('in_progress')
  inProgress,
  @JsonValue('pending_approval')
  pendingApproval,
  completed,
}

@JsonSerializable()
class Mission {
  final String id;
  @JsonKey(name: 'family_id')
  final String familyId;
  final String title;
  final MissionDifficulty difficulty;
  @JsonKey(name: 'icon_id')
  final String iconId;
  @JsonKey(name: 'assigned_to')
  final String? assignedTo;
  final MissionStatus status;
  @JsonKey(name: 'xp_reward')
  final int xpReward;
  @JsonKey(name: 'gold_reward')
  final int goldReward;
  @JsonKey(name: 'created_by')
  final String createdBy;

  const Mission({
    required this.id,
    required this.familyId,
    required this.title,
    required this.difficulty,
    required this.iconId,
    this.assignedTo,
    required this.status,
    required this.xpReward,
    required this.goldReward,
    required this.createdBy,
  });

  factory Mission.fromJson(Map<String, dynamic> json) => _$MissionFromJson(json);
  Map<String, dynamic> toJson() => _$MissionToJson(this);
}
