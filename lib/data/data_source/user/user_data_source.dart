import 'dart:io';

abstract class UserProfileDataSource {
  Future<Map<String, dynamic>> fetchCurrentUser({
    required String id,
    required String accessToken,
  });
  Future<Map<String, dynamic>> fetchUserStatistics();

  Future<Map<String, dynamic>> uploadAvatar({
    required String name,
    required File file,
  });
  Future<Map<String, dynamic>> fetchUser({required String id});
}
