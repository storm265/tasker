import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController textController;
  final String text, labelText;
  final bool isEmail;
  final bool isObcecure;
  final double top;
  final Function(String? text)? validateCallback;
  const TextFieldWidget({
    Key? key,
    required this.validateCallback,
    required this.labelText,
    required this.textController,
    required this.text,
    final this.isObcecure = false,
    this.top = 0,
    required this.isEmail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        TextFormField(
          scrollPhysics: const NeverScrollableScrollPhysics(),
          scrollPadding: const EdgeInsets.all(0),
          keyboardType:
              isEmail ? TextInputType.emailAddress : TextInputType.text,
          validator: (value) => validateCallback!(value),
          obscureText: isObcecure,
          controller: textController,
          decoration: InputDecoration(hintText: labelText),
        ),
      ],
    );
  }
}
