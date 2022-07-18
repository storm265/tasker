import 'package:flutter/widgets.dart';
import 'package:todo2/database/repository/auth_repository.dart';
import 'package:todo2/services/message_service/message_service.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';

class RestorePasswordController extends ChangeNotifier {
  RestorePasswordController({required this.authRepositoryController});

  final TextEditingController passwordController1 = TextEditingController();
  final TextEditingController passwordController2 = TextEditingController();
  final isClickedSubmit = ValueNotifier(true);

  final AuthRepositoryImpl authRepositoryController;

  bool get _isPasswordsSame =>
      passwordController1.text == passwordController2.text;
  bool get _isPasswordsEmpty =>
      passwordController1.text.isEmpty && passwordController2.text.isEmpty;

  bool get _isValidPasswordsLength =>
      (passwordController1.text.length & passwordController2.text.length) <= 6;

  void validatePassword({required BuildContext context}) async {
    String? message;
    isClickedSubmit.value = false;
    isClickedSubmit.notifyListeners();

    if (_isPasswordsEmpty) {
      message = 'Passwords  cannot be empty';
    } else if (!_isPasswordsSame) {
      message = 'Passwords are not same';
    } else if (_isValidPasswordsLength) {
      message = 'Passwords must be at least 6 characters long';
    } else {
      await updatePassword(context: context);
    }

    if (message != null) {
      await Future.delayed(const Duration(seconds: 2));
      MessageService.displaySnackbar(context: context, message: message);
    }
    isClickedSubmit.value = true;
    isClickedSubmit.notifyListeners();
  }

  Future<void> updatePassword({required BuildContext context}) async {
    try {
      final response = await authRepositoryController.updatePassword(
          password: passwordController1.text);
      if (response.error != null) {
        MessageService.displaySnackbar(
          context: context,
          message: response.error!.message.toString(),
        );
      } else {
        MessageService.displaySnackbar(
            context: context, message: 'Password updated');
        await Future.delayed(const Duration(seconds: 1),
            () => NavigationService.navigateTo(context, Pages.passwordChanged));
      }
    } catch (e) {
      throw Exception('Error in updatePassword() controller $e');
    }
  }
}
