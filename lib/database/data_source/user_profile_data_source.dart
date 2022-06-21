import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/database/database_scheme/user_profile_scheme.dart';
import 'package:todo2/services/supabase/constants.dart';

abstract class UserProfileDataSource {
  Future fetchUserName();
  Future fetchAvatar();
  Future insertImg({
    required String avatarUrl,
    required String username,
  });
}

class UserProfileDataSourceImpl implements UserProfileDataSource {
  final supabase = SupabaseSource().restApiClient;
  final _table = 'user_profile';

  @override
  Future<PostgrestResponse<dynamic>> insertImg({
    required String avatarUrl,
    required String username,
  }) async {
    try {
      final response = await supabase.from(_table).insert({
        UserProfileScheme.uid: supabase.auth.currentUser!.id,
        UserProfileScheme.avatarUrl: avatarUrl,
        UserProfileScheme.username: username,
        UserProfileScheme.createdAt: DateTime.now().toString(),
      }).execute();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PostgrestResponse<dynamic>> fetchUserName() async {
    try {
      final response = await supabase
          .from(_table)
          .select(UserProfileScheme.username)
          .eq(UserProfileScheme.uid, supabase.auth.currentUser!.id)
          .execute();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PostgrestResponse<dynamic>> fetchAvatar() async {
    try {
      final response = await SupabaseSource()
          .restApiClient
          .from(_table)
          .select(UserProfileScheme.avatarUrl)
          .eq(UserProfileScheme.uid, supabase.auth.currentUser!.id)
          .execute();
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
