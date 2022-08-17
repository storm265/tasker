// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_task/controller/add_task_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_task/controller/controller_inherited.dart';

class EnterUserWidget extends StatelessWidget {
  TextEditingController titleController;
  final Function(String)? onChanged;
  final bool isForFieldActive;
  final String text;
  EnterUserWidget({
    Key? key,
    required this.isForFieldActive,
    required this.onChanged,
    required this.titleController,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newTaskController =
        InheritedNewTaskController.of(context).addTaskController;
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 18,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        Container(
          width: 90,
          height: 45,
          decoration: BoxDecoration(
            color: const Color(0xFFF4F4F4),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: TextFormField(
              validator: (text) {
                if (text == 'Assignee' || text == 'Project') {
                  return 'Pick data!';
                }
                if (text == null || text.isEmpty) {
                  return 'Pick data!';
                }
                return null;
              },
              onChanged: onChanged,
              onTap: () {
                titleController.selection = TextSelection(
                  baseOffset: 0,
                  extentOffset: titleController.value.text.length,
                );

                isForFieldActive
                    ? newTaskController.changePanelStatus(
                        newStatus: InputFieldStatus.showUserPanel)
                    : newTaskController.changePanelStatus(
                        newStatus: InputFieldStatus.showProjectPanel);
              },
              controller: titleController,
              onEditingComplete: () => newTaskController.changePanelStatus(
                  newStatus: InputFieldStatus.hide),
              decoration: const InputDecoration(
                border: InputBorder.none,
                labelStyle: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
