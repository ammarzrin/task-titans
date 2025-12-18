import 'package:json_annotation/json_annotation.dart';

part 'reward.g.dart';

@JsonSerializable()
class Reward {
  final String id;
  @JsonKey(name: 'family_id')
  final String familyId;
  final String title;
  final int cost;
  @JsonKey(name: 'icon_id')
  final String iconId;
  final int? stock; // Null means unlimited

  const Reward({
    required this.id,
    required this.familyId,
    required this.title,
    required this.cost,
    required this.iconId,
    this.stock,
  });

  factory Reward.fromJson(Map<String, dynamic> json) => _$RewardFromJson(json);
  Map<String, dynamic> toJson() => _$RewardToJson(this);
}
