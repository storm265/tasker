// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/task_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/controller_inherited.dart';

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
              fontWeight: FontWeight.w200,
              fontSize: 18,
              fontStyle: FontStyle.italic,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Container(
          width: 100,
          height: 45,
          decoration: BoxDecoration(
            color: const Color(0xFFF4F4F4),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: isForFieldActive
                ? Row(
                    mainAxisAlignment:
                        newTaskController.pickedUser.value.id.isEmpty
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.start,
                    children: [
                      newTaskController.pickedUser.value.id.isEmpty
                          ? const SizedBox()
                          : const CircleAvatar(
                              radius: 17,
                              backgroundColor: Colors.red,
                            ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: SizedBox(
                          width: 40,
                          child: TextFormField(
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              overflow: TextOverflow.ellipsis,
                            ),
                            onChanged: onChanged,
                            onTap: () {
                              titleController.selection = TextSelection(
                                baseOffset: 0,
                                extentOffset: titleController.value.text.length,
                              );

                              isForFieldActive
                                  ? newTaskController.changePanelStatus(
                                      newStatus: InputFieldStatus.showUserPanel,
                                    )
                                  : newTaskController.changePanelStatus(
                                      newStatus:
                                          InputFieldStatus.showProjectPanel,
                                    );
                            },
                            controller: titleController,
                            onEditingComplete: () =>
                                newTaskController.changePanelStatus(
                                    newStatus: InputFieldStatus.hide),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelStyle: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: TextFormField(
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onChanged: onChanged,
                      onTap: () {
                        titleController.clear();

                        isForFieldActive
                            ? newTaskController.changePanelStatus(
                                newStatus: InputFieldStatus.showUserPanel,
                              )
                            : newTaskController.changePanelStatus(
                                newStatus: InputFieldStatus.showProjectPanel,
                              );
                      },
                      controller: titleController,
                      onEditingComplete: () => newTaskController
                          .changePanelStatus(newStatus: InputFieldStatus.hide),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelStyle: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
