// ignore_for_file: use_build_context_synchronously
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/database/model/task_models/task_model.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/task_list.dart';
import 'package:todo2/presentation/pages/menu_pages/task/view_task/controller/view_task_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/task/view_task/widgets/add_member/add_member_dialog.dart';
import 'package:todo2/services/message_service/message_service.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';

Future<void> showDetailedOptions({
  required TaskList taskListController,
  required BuildContext context,
  required ViewTaskController viewTaskController,
  required TaskModel selectedTask,
}) async {
  final List<String> items = selectedTask.isCompleted == true &&
          DateTime.now().isBefore(selectedTask.dueDate)
      ? [
          LocaleKeys.delete_task.tr(),
        ]
      : [
          LocaleKeys.add_member.tr(),
          LocaleKeys.edit_task.tr(),
          LocaleKeys.delete_task.tr(),
        ];

  await showDialog(
    barrierColor: Colors.black26,
    context: context,
    builder: (_) => Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 150,
          right: 30,
          top: 70,
        ),
        child: AlertDialog(
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          alignment: Alignment.topRight,
          content: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: items.length,
            shrinkWrap: true,
            itemBuilder: ((_, i) {
              return InkWell(
                onTap: () async {
                  switch (i) {
                    case 0:
                      if (items.length == 1) {
                        await taskListController
                            .deleteTask(
                              taskId: selectedTask.id,
                              taskRepository: taskListController.taskRepository,
                            )
                            .then(
                              (_) => MessageService.displaySnackbar(
                                context: context,
                                message: LocaleKeys.deleted.tr(),
                              ),
                            );
                        Navigator.pop(context);
                        Navigator.pop(context);
                      } else {
                        // TODO add member
                        await showDialog(
                          context: context,
                          builder: (_) => AddMemberDialog(
                            viewTaskController: viewTaskController,
                          ),
                        );
                      }

                      break;
                    case 1:
                      Navigator.pop(context);
                      Navigator.pop(context);
                      await Navigator.pushNamed(
                        context,
                        Pages.addTask.type,
                        arguments: selectedTask.toMap(),
                      );

                      break;
                    case 2:
                      await taskListController
                          .deleteTask(
                            taskId: selectedTask.id,
                            taskRepository: taskListController.taskRepository,
                          )
                          .then(
                            (_) => MessageService.displaySnackbar(
                              context: context,
                              message: LocaleKeys.deleted.tr(),
                            ),
                          );
                      Navigator.pop(context);
                      Navigator.pop(context);
                      break;
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    top: 10,
                    bottom: 10,
                  ),
                  child: Text(
                    items[i],
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    ),
  );
}
