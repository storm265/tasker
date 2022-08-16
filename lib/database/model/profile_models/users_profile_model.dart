import 'package:json_annotation/json_annotation.dart';
part 'users_profile_model.g.dart';

@JsonSerializable()
class UserProfileModel {
 final String id;
final  String username;
 final String avatarUrl;
 final String createdAt;

  UserProfileModel({
    required this.id,
    required this.username,
    required this.avatarUrl,
    required this.createdAt,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);
      
}
