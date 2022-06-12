
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/supabase/constants.dart';

abstract class AuthDataSource<T> {
  Future<T> signUp({
    required String email,
    required String password,
  });

  Future<T> signIn({
    required String email,
    required String password,
  });

  Future<T> resetPasswordForMail({required String email});
  Future<T> updatePassword({required String password});
  Future<T> signOut();
}

class AuthDataSourceImpl implements AuthDataSource {
  final SupabaseSource _supabase = SupabaseSource();
  final SupabaseConfiguration _configuration = SupabaseConfiguration();

  @override
  Future<GotrueJsonResponse> resetPasswordForMail({
    required String email,
  }) {
    try {
      final _responce = _supabase.dbClient.auth.api.resetPasswordForEmail(
        email,
        options: AuthOptions(redirectTo: _configuration.redirectTo),
      );

      return _responce;
    } catch (e) {
      ErrorService.printError('Error in resetPasswordForMail() dataSource: $e');
    }
    return throw Exception('Error in resetPasswordForMail() dataSource');
  }

  @override
  Future<GotrueSessionResponse> signIn({
    required String email,
    required String password,
  }) {
    try {
      final _responce = _supabase.dbClient.auth.signIn(
        email: email,
        password: password,
      );
      return _responce;
    } catch (e) {
      ErrorService.printError('Error in signIn() dataSource: $e');
    }
    return throw Exception('Error in signIn() dataSource');
  }

  @override
  Future<GotrueResponse> signOut() async {
    try {
      final _responce = _supabase.dbClient.auth.signOut();
      return _responce;
    } catch (e) {
      ErrorService.printError('Error in signOut() dataSource: $e');
    }
    return throw Exception('Error in signOut() dataSource');
  }

  @override
  Future<GotrueSessionResponse> signUp({
    required String email,
    required String password,
  }) {
    try {
      final _responce = _supabase.dbClient.auth.signUp(
        email,
        password,
      );
      return _responce;
    } catch (e) {
      ErrorService.printError('Error in signUp() dataSource: $e');
    }
    return throw Exception('Error in signUp() dataSource');
  }

  @override
  Future<GotrueUserResponse> updatePassword({required String password}) async {
    try {
      final _responce = _supabase.dbClient.auth.api.updateUser(
        _supabase.dbClient.auth.currentSession!.accessToken,
        UserAttributes(password: password),
      );
      return _responce;
    } catch (e) {
      ErrorService.printError('Error in update password dataSource: $e');
    }
    throw Exception('Error in update password dataSource');
  }
}
