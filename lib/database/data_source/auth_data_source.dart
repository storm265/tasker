import 'dart:developer';

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

class AuthDataSourceImpl implements AuthDataSource {
  SupabaseSource supabase;
  SupabaseConfiguration configuration;

  AuthDataSourceImpl({required this.supabase, required this.configuration});

  @override
  Future<GotrueJsonResponse> resetPasswordForMail({
    required String email,
  }) async {
    try {
      final responce =
          await supabase.restApiClient.auth.api.resetPasswordForEmail(
        email,
        options: AuthOptions(redirectTo: configuration.redirectTo),
      );

      return responce;
    } catch (e) {
      ErrorService.printError('Error in resetPasswordForMail() dataSource: $e');
      rethrow;
    }
  }

  @override
  Future<GotrueSessionResponse> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabase.restApiClient.auth.signIn(
        email: email,
        password: password,
      );
      return response;
    } catch (e) {
      ErrorService.printError('Error in signIn() dataSource: $e');
      rethrow;
    }
  }

  @override
  Future<GotrueResponse> signOut() async {
    try {
      final responce = await supabase.restApiClient.auth.signOut();
      return responce;
    } catch (e) {
      ErrorService.printError('Error in signOut() dataSource: $e');
      rethrow;
    }
  }

  @override
  Future<GotrueSessionResponse> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabase.restApiClient.auth.signUp(
        email,
        password,
      );
      return response;
    } catch (e) {
      ErrorService.printError('Error in signUp() dataSource: $e');
      rethrow;
    }
  }

  @override
  Future<GotrueUserResponse> updatePassword({required String password}) async {
    try {
      final response = await supabase.restApiClient.auth.api.updateUser(
        supabase.restApiClient.auth.currentSession!.accessToken,
        UserAttributes(password: password),
      );
      return response;
    } catch (e) {
      ErrorService.printError('Error in updatePassword() dataSource: $e');
      rethrow;
    }
  }
}
