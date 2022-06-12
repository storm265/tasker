import 'package:flutter/widgets.dart';
import 'package:todo2/database/repository/auth/auth_repository.dart';
import 'package:todo2/services/message_service/message_service.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';

class RestorePasswordController {
  final TextEditingController passwordController1 = TextEditingController();
  final TextEditingController passwordController2 = TextEditingController();

  final _authRepositoryController = AuthRepositoryImpl();
  bool get _isPasswordsSame =>
      passwordController1.text == passwordController2.text;
  bool get _isPasswordsEmpty =>
      passwordController1.text.isEmpty && passwordController2.text.isEmpty;

  bool get _isValidPasswordsLength =>
      passwordController1.text.length & passwordController2.text.length <= 6;

  void validatePassword(BuildContext context) async {
    String? _message;
    if (_isPasswordsEmpty) {
      _message = 'Passwords  cannot be empty';
    } else if (_isValidPasswordsLength) {
      _message = 'Passwords must be at least 6 characters long';
    } else if (!_isPasswordsSame) {
      _message = 'Passwords are not same';
    } else {
      await updatePassword(context);
    }
    (_message == null)
        ? ''
        : MessageService.displaySnackbar(context: context, message: _message);
  }

  Future<void> updatePassword(BuildContext context) async {
    try {
      _authRepositoryController
          .updatePassword(password: passwordController1.text)
          .then((_) =>
              NavigationService.navigateTo(context, Pages.passwordChanged));
    } catch (e) {
      throw Exception('Error in updatePassword() controller $e');
    }
  }
}
