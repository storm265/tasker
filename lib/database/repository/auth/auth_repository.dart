import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/database/data_source/auth_data_source.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/message_service/message_service.dart';
import 'package:todo2/services/supabase/constants.dart';

abstract class AuthRepository {
  Future signUp({
    required BuildContext context,
    required String email,
    required String password,
  });

  Future signIn({
    required BuildContext context,
    required String email,
    required String password,
  });

  Future resetPassword({
    required BuildContext context,
    required String email,
  });
  Future updatePassword({required String password});

  Future signOut({required BuildContext context});
}

class AuthRepositoryImpl implements AuthRepository {
  final _authDataSource = AuthDataSourceImpl(
    supabase: SupabaseSource(),
    configuration: SupabaseConfiguration(),
  );

  @override
  Future<GotrueSessionResponse> signIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _authDataSource.signIn(
        email: email,
        password: password,
      );
      return response;
    } catch (e) {
      ErrorService.printError('Error in signIn() repository: $e');
      rethrow;
    }
  }

  @override
  Future<GotrueSessionResponse> signUp({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _authDataSource.signUp(
        email: email,
        password: password,
      );
      return response;
    } catch (e) {
      ErrorService.printError('Error in signUp() repository: $e');
      rethrow;
    }
  }

  @override
  Future<GotrueResponse> signOut({required BuildContext context}) async {
    try {
      final response = await _authDataSource.signOut();
      return response;
    } catch (e) {
      ErrorService.printError('Error in signOut() repository: $e');
      rethrow;
    }
  }

  @override
  Future<GotrueJsonResponse> resetPassword({
    required BuildContext context,
    required String email,
  }) async {
    try {
      final response = await _authDataSource.resetPasswordForMail(email: email);
      return response;
    } catch (e) {
      ErrorService.printError('Error in resetPassword() repository: $e');
      rethrow;
    }
  }

  @override
  Future<GotrueUserResponse> updatePassword({required String password}) async {
    try {
      final response = await _authDataSource.updatePassword(password: password);
      return response;
    } catch (e) {
      ErrorService.printError('Error in updatePassword() repository: $e');
      rethrow;
    }
  }
}
