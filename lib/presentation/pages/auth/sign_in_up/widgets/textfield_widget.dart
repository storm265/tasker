import 'package:flutter/material.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController textController;
  final String title;
  final String labelText;
  final bool isEmail;
  final bool isObcecure;
  final double top;
  final VoidCallback? onTap;
  final Function(String? text)? validateCallback;
  const TextFieldWidget({
    Key? key,
    required this.validateCallback,
    required this.labelText,
    required this.textController,
    required this.title,
    final this.isObcecure = false,
    this.top = 0,
    this.onTap,
    required this.isEmail,
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
          onTap: onTap,
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
