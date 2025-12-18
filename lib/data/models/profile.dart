import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

enum UserRole {
  parent,
  child,
}

@JsonSerializable()
class Profile {
  final String id;
  @JsonKey(name: 'family_id')
  final String familyId;
  final UserRole role;
  final String username;
  @JsonKey(name: 'avatar_id')
  final String avatarId;
  @JsonKey(name: 'pin_code')
  final String pinCode;
  
  // Child stats (nullable for parents)
  final int? xp;
  final int? gold;
  final int? level;

  const Profile({
    required this.id,
    required this.familyId,
    required this.role,
    required this.username,
    required this.avatarId,
    required this.pinCode,
    this.xp,
    this.gold,
    this.level,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
