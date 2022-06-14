import 'package:flutter/material.dart';
import 'package:todo2/controller/auth/form_validator_controller.dart';
import 'package:todo2/database/repository/auth/auth_repository.dart';
import 'package:todo2/presentation/widgets/common/appbar_widget.dart';
import 'package:todo2/presentation/widgets/auth_pages/widgets/sign_up_button_widget.dart';
import 'package:todo2/presentation/widgets/auth_pages/widgets/signup_to_continue_widget.dart';
import 'package:todo2/presentation/widgets/auth_pages/widgets/textfield_widget.dart';
import 'package:todo2/presentation/widgets/auth_pages/widgets/welcome_text_widget.dart';
import 'package:todo2/presentation/widgets/common/disabled_glow_single_child_scroll_widget.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _authRepositoryController = AuthRepositoryImpl();
  final _validatorController = FormValidatorController();
  bool _isClicked = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(
        showLeadingButton: true,
        appBarColor: Colors.white,
      ),
      body: DisabledGlowWidget(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: [
              const TitleTextWidget(text: 'Forgot Password'),
              const SubTitleWidget(
                text:
                    'Please enter your email below to recevie\nyour password reset instructions',
              ),
              TextFieldWidget(
                validateCallback: (text) =>
                    _validatorController.validateEmail(text!),
                left: 25,
                top: 160,
                isObsecureText: false,
                textController: _emailController,
                labelText: 'Email:',
                text: 'Username',
              ),
              SignUpButtonWidget(
                height: 270,
                buttonText: 'Send Request',
                onPressed: _isClicked
                    ? () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() => _isClicked = false);
                          await _authRepositoryController.resetPassword(
                            context: context,
                            email: _emailController.text,
                          );
                        }
                        setState(() => _isClicked = true);
                      }
                    : null,
              )
            ],
          ),
        ),
      ),
    );
  }
}
