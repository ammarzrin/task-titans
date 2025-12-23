import 'package:json_annotation/json_annotation.dart';

part 'family.g.dart';

@JsonSerializable()
class Family {
  final String id;
  final String name;
  @JsonKey(name: 'invite_code')
  final String inviteCode;

  const Family({
    required this.id,
    required this.name,
    required this.inviteCode,
  });

  factory Family.fromJson(Map<String, dynamic> json) => _$FamilyFromJson(json);
  Map<String, dynamic> toJson() => _$FamilyToJson(this);
}
