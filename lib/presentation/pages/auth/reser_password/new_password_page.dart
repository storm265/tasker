import 'package:flutter/material.dart';
import 'package:todo2/database/repository/auth/auth_repository.dart';
import 'package:todo2/presentation/pages/auth/reser_password/controller/padding_constant.dart';
import 'package:todo2/presentation/pages/auth/reser_password/controller/restore_password_controller.dart';
import 'package:todo2/presentation/pages/auth/reser_password/widgets/restore_password_controller.dart';
import 'package:todo2/presentation/pages/auth/reser_password/widgets/update_password_widget.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/presentation/widgets/common/will_pop_scope_wrapper.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({Key? key}) : super(key: key);

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  final _restorePasswordController =
      RestorePasswordController(authRepositoryController: AuthRepositoryImpl());

  @override
  void dispose() {
    _restorePasswordController.passwordController1.dispose();
    _restorePasswordController.passwordController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isUpdatePassword = ModalRoute.of(context)!.settings.arguments;
    return WillPopWrapper(
      child: AppbarWrapperWidget(
        shouldUsePopMethod: true,
        showLeadingButton: true,
        isRedAppBar: false,
        child: Padding(
          padding: const EdgeInsets.all(paddingAll),
          child: isUpdatePassword == true
              ? RestorePasswordWidget(restoreController: _restorePasswordController)
              : UpdatePasswordWidget(restoreController: _restorePasswordController)
        ),
      ),
    );
  }
}

