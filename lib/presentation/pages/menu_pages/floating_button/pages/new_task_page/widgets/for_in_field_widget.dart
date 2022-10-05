import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/task_controller.dart';

class EnterUserWidget extends StatelessWidget {
  final TextEditingController titleController;
  final AddTaskController taskController;
  final Function(String)? onChanged;
  final bool isForFieldActive;
  final String text;
  const EnterUserWidget({
    Key? key,
    required this.isForFieldActive,
    required this.onChanged,
    required this.titleController,
    required this.text,
    required this.taskController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                ? ValueListenableBuilder(
                    valueListenable: taskController.pickedDate,
                    builder: (_, value, __) => Row(
                      mainAxisAlignment:
                          taskController.pickedUser.value.id.isEmpty
                              ? MainAxisAlignment.center
                              : MainAxisAlignment.start,
                      children: [
                        taskController.pickedUser.value.id.isEmpty
                            ? const SizedBox()
                            : Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: CircleAvatar(
                                  radius: 17,
                                  backgroundColor: Colors.grey,
                                  backgroundImage: NetworkImage(
                                    taskController.pickedUser.value.avatarUrl,
                                    headers: taskController.imageHeader,
                                  ),
                                ),
                              ),
                        SizedBox(
                          width: 55,
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
                                  ? taskController.changePanelStatus(
                                      newStatus: InputFieldStatus.showUserPanel,
                                    )
                                  : taskController.changePanelStatus(
                                      newStatus:
                                          InputFieldStatus.showProjectPanel,
                                    );
                            },
                            controller: titleController,
                            onEditingComplete: () {
                              taskController.changePanelStatus(
                                  newStatus: InputFieldStatus.hide);
                              FocusScope.of(context).unfocus();
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelStyle: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
                            ? taskController.changePanelStatus(
                                newStatus: InputFieldStatus.showUserPanel,
                              )
                            : taskController.changePanelStatus(
                                newStatus: InputFieldStatus.showProjectPanel,
                              );
                      },
                      controller: titleController,
                      onEditingComplete: () {
                        taskController.changePanelStatus(
                            newStatus: InputFieldStatus.hide);
                        FocusScope.of(context).unfocus();
                      },
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
