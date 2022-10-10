import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/generated/locale_keys.g.dart';

class DescriptionTextField extends StatelessWidget {
  final TextEditingController descriptionTextController;
  final String? hintText;
  const DescriptionTextField({
    super.key,
    required this.descriptionTextController,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: TextFormField(
        style: const TextStyle(
          fontSize: 18,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w200,
        ),
        validator: (text) {
          if (text == null || text.isEmpty) {
            return LocaleKeys.please_enter_text.tr();
          }
          return null;
        },
        controller: descriptionTextController,
        onEditingComplete: () => FocusScope.of(context).unfocus(),
        maxLength: 512,
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
        keyboardType: TextInputType.multiline,
        maxLines: null,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color(0xFFD8D8D8),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
