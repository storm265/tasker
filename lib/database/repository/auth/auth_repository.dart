import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/database/data_source/auth_data_source.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/message_service/message_service.dart';

abstract class AuthRepository<T> {
  Future<T> signUp({
    required BuildContext context,
    required String email,
    required String password,
  });

  Future<T> signIn({
    required BuildContext context,
    required String email,
    required String password,
  });

  Future<T> resetPassword({
    required BuildContext context,
    required String email,
  });
  Future<T> updatePassword({required String password});

  Future<T> signOut({required BuildContext context});
}

class AuthRepositoryImpl implements AuthRepository {
  final _authDataSource = AuthDataSourceImpl();
  @override
  Future<void> signIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      final _responce =
          await _authDataSource.signIn(email: email, password: password);

      if (_responce.error != null) {
        MessageService.displaySnackbar(
            context: context, message: _responce.error!.message.toString());
      }
    } catch (e) {
      throw Exception('Error in signIn() repository $e');
    }
  }

  @override
  Future<void> signUp({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      final _responce = await _authDataSource.signUp(
        email: email,
        password: password,
      );
      if (_responce.error != null) {
        MessageService.displaySnackbar(
          context: context,
          message: _responce.error!.message.toString(),
        );
      }
    } catch (e) {
      throw Exception('Error in signUp() repository $e');
    }
  }

  @override
  Future<void> signOut({required BuildContext context}) async {
    try {
      GotrueResponse _responce = await _authDataSource.signOut();
      if (_responce.error != null) {
        MessageService.displaySnackbar(
          context: context,
          message: _responce.error!.message.toString(),
        );
      }
    } catch (e) {
      ErrorService.printError('Error in signOut() repository: $e');
    }
  }

  @override
  Future<void> resetPassword({
    required BuildContext context,
    required String email,
  }) async {
    try {
      final _responce =
          await _authDataSource.resetPasswordForMail(email: email);

      if (_responce.error != null) {
        MessageService.displaySnackbar(
          context: context,
          message: _responce.error!.message.toString(),
        );
      }
    } catch (e) {
      throw Exception('Error in resetPassword() repository: $e');
    }
  }

  @override
  Future<void> updatePassword({required String password}) async {
    try {
      final _responce =
          await _authDataSource.updatePassword(password: password);
      if (_responce.error != null) {
        ErrorService.printError(_responce.error!.message);
      }
    } catch (e) {
      ErrorService.printError('Error in updatePassword() repository: $e');
    }
  }
}
