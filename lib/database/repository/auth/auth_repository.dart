import 'package:flutter/material.dart';
import 'package:todo2/database/data_source/auth_data_source.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/message_service/message_service.dart';

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
    required VoidCallback navigatorCallback,
  });

  Future resetPassword({
    required BuildContext context,
    required String email,
  });
  Future updatePassword({required String password});

  Future signOut({required BuildContext context});
}

class AuthRepositoryImpl implements AuthRepository {
  final _authDataSource = AuthDataSourceImpl();
  @override
  Future<void> signIn({
    required BuildContext context,
    required String email,
    required String password,
    required VoidCallback navigatorCallback,
  }) async {
    try {
      final response = await _authDataSource.signIn(
        email: email,
        password: password,
      );

      if (response.error != null) {
        MessageService.displaySnackbar(
          context: context,
          message: response.error!.message.toString(),
        );
      } else {
        navigatorCallback();
      }
    } catch (e) {
      ErrorService.printError('Error in signIn() repository: $e');
      rethrow;
    }
  }

  @override
  Future<void> signUp({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _authDataSource.signUp(
        email: email,
        password: password,
      );
      if (response.error != null) {
        MessageService.displaySnackbar(
          context: context,
          message: response.error!.message.toString(),
        );
      }
    } catch (e) {
      ErrorService.printError('Error in signUp() repository: $e');
      rethrow;
    }
  }

  @override
  Future<void> signOut({required BuildContext context}) async {
    try {
      final response = await _authDataSource.signOut();
      if (response.error != null) {
        MessageService.displaySnackbar(
          context: context,
          message: response.error!.message.toString(),
        );
      }
    } catch (e) {
      ErrorService.printError('Error in signOut() repository: $e');
      rethrow;
    }
  }

  @override
  Future<void> resetPassword({
    required BuildContext context,
    required String email,
  }) async {
    try {
      final response = await _authDataSource.resetPasswordForMail(email: email);

      if (response.error != null) {
        MessageService.displaySnackbar(
          context: context,
          message: response.error!.message.toString(),
        );
      }
    } catch (e) {
      ErrorService.printError('Error in resetPassword() repository: $e');
      rethrow;
    }
  }

  @override
  Future<void> updatePassword({required String password}) async {
    try {
      final response = await _authDataSource.updatePassword(password: password);
      if (response.error != null) {
        ErrorService.printError(response.error!.message);
      }
    } catch (e) {
      ErrorService.printError('Error in updatePassword() repository: $e');
      rethrow;
    }
  }
}
