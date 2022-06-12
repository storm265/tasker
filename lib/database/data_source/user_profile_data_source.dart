import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/database/database_scheme/user_profile_scheme.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/supabase/constants.dart';

abstract class UserProfileDataSource<T> {
  Future<T> fetchUserName();
  Future<T> fetchAvatar();
  Future<T> insertImg({
    required String avatarUrl,
    required String username,
  });
}

class UserProfileDataSourceImpl implements UserProfileDataSource {
  final supabase = SupabaseSource().dbClient;
  final _table = 'user_profile';

  @override
  Future<PostgrestResponse<dynamic>> insertImg({
    required String avatarUrl,
    required String username,
  }) async {
    try {
      final _responce = await supabase.from(_table).insert({
        UserProfileScheme.uid: supabase.auth.currentUser!.id,
        UserProfileScheme.avatarUrl: avatarUrl,
        UserProfileScheme.username: username,
        UserProfileScheme.createdAt: DateTime.now().toString(),
      }).execute();
      return _responce;
    } catch (e) {
      ErrorService.printError('Error in insertImg() dataSource: $e');
    }
    throw Exception('Error in insertImg() dataSource');
  }

  @override
  Future<PostgrestResponse<dynamic>> fetchUserName() async {
    try {
      final _responce = await supabase
          .from(_table)
          .select(UserProfileScheme.username)
          .eq(UserProfileScheme.uid, supabase.auth.currentUser!.id)
          .execute();
      return _responce;
    } catch (e) {
      ErrorService.printError('Error in fetchUserName() dataSource: $e');
    }
    throw Exception('Error in fetchUserName() dataSource');
  }

  @override
  Future<PostgrestResponse<dynamic>> fetchAvatar() async {
    try {
      final _responce = await SupabaseSource()
          .dbClient
          .from(_table)
          .select(UserProfileScheme.avatarUrl)
          .eq(UserProfileScheme.uid, supabase.auth.currentUser!.id)
          .execute();
      return _responce;
    } catch (e) {
      ErrorService.printError('Error in fetchAvatar() dataSource: $e');
    }
    throw Exception('Error in fetchAvatar() dataSource');
  }
}
