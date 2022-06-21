import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/supabase/constants.dart';

abstract class AuthDataSource {
  Future signUp({
    required String email,
    required String password,
  });

  Future signIn({
    required String email,
    required String password,
  });

  Future resetPasswordForMail({required String email});
  Future updatePassword({required String password});
  Future signOut();
}

// TODO: Inject dependencies
class AuthDataSourceImpl implements AuthDataSource {
  final SupabaseSource _supabase = SupabaseSource();
  final SupabaseConfiguration _configuration = SupabaseConfiguration();

  @override
  Future<GotrueJsonResponse> resetPasswordForMail({
    required String email,
  }) {
    try {
      final responce = _supabase.restApiClient.auth.api.resetPasswordForEmail(
        email,
        options: AuthOptions(redirectTo: _configuration.redirectTo),
      );

      return responce;
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
      final responce = _supabase.restApiClient.auth.signIn(
        email: email,
        password: password,
      );
      return responce;
    } catch (e) {
      ErrorService.printError('Error in signIn() dataSource: $e');
    }
    return throw Exception('Error in signIn() dataSource');
  }

  @override
  Future<GotrueResponse> signOut() async {
    try {
      final responce = _supabase.restApiClient.auth.signOut();
      return responce;
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
      final response = _supabase.restApiClient.auth.signUp(
        email,
        password,
      );
      return response;
    } catch (e) {
     rethrow;
    }
  
    
  }

  @override
  Future<GotrueUserResponse> updatePassword({required String password}) async {
    try {
      final response = _supabase.restApiClient.auth.api.updateUser(
        _supabase.restApiClient.auth.currentSession!.accessToken,
        UserAttributes(password: password),
      );
      return response;
    } catch (e) {
      rethrow;
    }
   
  }
}
