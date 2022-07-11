import 'package:flutter/material.dart';

class AddTextFieldWidget extends StatelessWidget {
  final String? hintText;
  final TextEditingController titleController;
  final VoidCallback? onTap;
  final VoidCallback? onEdiditionCompleteCallback;
  final int? maxLength;
  final int? maxLines;

  const AddTextFieldWidget({
    Key? key,
    required this.titleController,
    this.onTap,
    this.maxLength,
    this.maxLines,
    this.onEdiditionCompleteCallback,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      validator: (text) {
        if (text!.isEmpty) {
          return 'Please enter text';
        } else {
          return null;
        }
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onEditingComplete: onEdiditionCompleteCallback,
      style: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        fontStyle: FontStyle.normal,
        color: Colors.black,
      ),
      controller: titleController,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 18,
          fontStyle: FontStyle.italic,
          color: Colors.black,
        ),
      ),
    );
  }
}
