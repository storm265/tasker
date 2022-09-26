import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/task_controller.dart';

class DescriptionTextField extends StatelessWidget {
  final AddTaskController taskController;
  const DescriptionTextField({
    super.key,
    required this.taskController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
        fontSize: 18,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w300,
      ),
      validator: (text) {
        if (text == null || text.isEmpty) {
          return LocaleKeys.please_enter_text.tr();
        }
        return null;
      },
      controller: taskController.descriptionController,
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
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
    );
  }
}
