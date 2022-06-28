// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_task/controller/add_task_controller.dart';

final newTaskController = NewTaskController();

class EnterUserWidget extends StatelessWidget {
  TextEditingController titleController;

  final String text;
  EnterUserWidget({
    Key? key,
    required this.titleController,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 5),
          child: Text(
            'For',
            style: TextStyle(
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
            child: TextField(
              onTap: () {
                titleController.selection = TextSelection(
                  baseOffset: 0,
                  extentOffset: titleController.value.text.length,
                );

                newTaskController.showPickUserWidget(true);
              },
              controller: titleController,
              onEditingComplete: ()=>     newTaskController.showPickUserWidget(false),
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
