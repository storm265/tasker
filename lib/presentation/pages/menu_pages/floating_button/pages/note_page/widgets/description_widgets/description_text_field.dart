import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/controller_inherited.dart';

class DescriptionTextField extends StatelessWidget {
  const DescriptionTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final newTaskController =
        InheritedNewTaskController.of(context).addTaskController;
    return TextFormField(
      style: const TextStyle(
        fontSize: 18,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w300,
      ),
      validator: (text) {
        if (text == null || text.isEmpty) {
          return 'Please enter description text';
        }
        return null;
      },
      controller: newTaskController.descriptionController,
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
