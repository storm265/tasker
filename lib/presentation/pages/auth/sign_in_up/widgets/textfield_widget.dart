import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/controller/sign_in_controller.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/controller/sign_up_controller.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController textController;
  final String title;
  final String labelText;
  final bool isEmail;
  final bool isObcecure;
  final double top;

  final SignInController? signInController;
  final SignUpController? signUpController;
  final Function(String? text)? validateCallback;
  const TextFieldWidget({
    Key? key,
    required this.validateCallback,
    required this.labelText,
    required this.textController,
    required this.title,
    this.isObcecure = false,
    this.top = 0,
    required this.isEmail,
    this.signInController,
    this.signUpController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        TextFormField(
          onTap: () => signInController == null
              ? signUpController?.changeScrollStatus(isActive: true)
              : signInController?.changeScrollStatus(isActive: true),
          onEditingComplete: () {
            FocusScope.of(context).unfocus();
            signInController == null
                ? signUpController?.changeScrollStatus(isActive: false)
                : signInController?.changeScrollStatus(isActive: false);
          },
          scrollPhysics: const NeverScrollableScrollPhysics(),
          scrollPadding: const EdgeInsets.all(0),
          keyboardType:
              isEmail ? TextInputType.emailAddress : TextInputType.text,
          validator: (value) => validateCallback!(value),
          obscureText: isObcecure,
          controller: textController,
          decoration: InputDecoration(
            hintText: labelText,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFFC6C6C6),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFD8D8D8)),
            ),
          ),
        ),
      ],
    );
  }
}
