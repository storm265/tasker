import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/generated/locale_keys.g.dart';

class AddTextFieldWidget extends StatelessWidget {
  const AddTextFieldWidget({
    Key? key,
    required this.titleController,
    this.onTap,
    this.maxLength = 32,
    this.textInputType,
    this.onEdiditionCompleteCallback,
    this.hintText,
  }) : super(key: key);

  final String? hintText;

  final TextEditingController titleController;

  final VoidCallback? onTap;

  final VoidCallback? onEdiditionCompleteCallback;

  final int maxLength;

  final TextInputType? textInputType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      buildCounter: (
        context, {
        required currentLength,
        required isFocused,
        maxLength,
      }) =>
          maxLength == currentLength
              ? Text(
                  '$maxLength/$maxLength',
                  style: const TextStyle(color: Colors.red),
                )
              : null,
      keyboardType: textInputType,
      maxLength: maxLength,
      validator: (text) {
        if (text!.trim().isEmpty) {
          return LocaleKeys.please_enter_text.tr();
        } else {
          return null;
        }
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
        fontStyle: FontStyle.normal,
        color: Colors.black,
      ),
      controller: titleController,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: const TextStyle(
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.w300,
          fontSize: 18,
          fontStyle: FontStyle.italic,
          color: Colors.black,
        ),
      ),
    );
  }
}
