import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/database/database_scheme/user_profile_scheme.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/supabase/constants.dart';

abstract class UserProfileDataSource {
  Future fetchUserName();
  Future fetchAvatar();
  Future insertUserProfile({
    required String avatarUrl,
    required String username,
  });
}

class UserProfileDataSourceImpl implements UserProfileDataSource {
  final supabase = SupabaseSource().restApiClient;
  final _table = 'user_profile';

  @override
  Future<PostgrestResponse<dynamic>> insertUserProfile({
    required String avatarUrl,
    required String username,
  }) async {
    try {
      final response = await supabase.from(_table).insert({
        UserProfileScheme.username: username,
        UserProfileScheme.avatarUrl: avatarUrl,
        UserProfileScheme.uuid: supabase.auth.currentUser!.id,
        UserProfileScheme.createdAt: DateTime.now().toString(),
      }).execute();

      return response;
    } catch (e) {
      ErrorService.printError(
          'Error in UserProfileDataSourceImpl insertImg() dataSource: $e');
      rethrow;
    }
  }

  @override
  Future<PostgrestResponse<dynamic>> fetchUserName() async {
    try {
      final response = await supabase
          .from(_table)
          .select(UserProfileScheme.username)
          .eq(UserProfileScheme.uuid, supabase.auth.currentUser!.id)
          .execute();
      return response;
    } catch (e) {
      ErrorService.printError(
          'Error in UserProfileDataSourceImpl fetchUserName() dataSource: $e');
      rethrow;
    }
  }

  @override
  Future<PostgrestResponse<dynamic>> fetchAvatar() async {
    try {
      final response = await SupabaseSource()
          .restApiClient
          .from(_table)
          .select('avatar_url')
          .eq(UserProfileScheme.uuid, supabase.auth.currentUser!.id)
          .execute();
      
      return response;
    } catch (e, t) {
      ErrorService.printError(
          'Error in UserProfileDataSourceImpl fetchAvatar() dataSource: $e, trace: $t');
      rethrow;
    }
  }
}
