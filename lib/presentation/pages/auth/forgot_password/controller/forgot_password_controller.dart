import 'package:flutter/cupertino.dart';
import 'package:todo2/database/repository/auth/auth_repository.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/controller/form_validator_controller.dart';

class ForgotPasswordController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final authRepositoryController = AuthRepositoryImpl();
  final validatorController = FormValidatorController();
  final isClickedButton = ValueNotifier(true);

  Future<void> sendEmail({
    required BuildContext context,
    required String email,
  }) async {
    if (formKey.currentState!.validate()) {
      isClickedButton.value = false;
      isClickedButton.notifyListeners();
      await authRepositoryController.resetPassword(
        context: context,
        email: email,
      );
    }
    isClickedButton.value = true;
    isClickedButton.notifyListeners();
  }
}
