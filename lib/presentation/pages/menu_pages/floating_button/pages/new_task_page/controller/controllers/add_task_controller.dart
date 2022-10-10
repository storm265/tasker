import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/base_tasks_controller.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';



class AddEditTaskController extends BaseTasksController {
  AddEditTaskController({
    required super.taskValidator,
    required super.projectController,
    required super.attachmentsProvider,
    required super.secureStorage,
    required super.panelProvider,
    required super.memberProvider,
    required super.taskRepository,
  });

  Future<void> createTask(BuildContext context) async {
    try {
      changeSubmitButton(false);
      if (await taskValidator.tryValidate(
        context: context,
        formKey: formKey,
      )) {
        List<String> members = [];
        if (super.memberProvider.taskMembers.value.isNotEmpty) {
          for (var element in super.memberProvider.taskMembers.value) {
            members.add(element.id);
          }
        }

        final model = await super.taskRepository.createTask(
              title: titleTextController.text,
              description: descriptionTextController.text,
              assignedTo: pickedUser.value?.id,
              projectId: pickedProject.value!.id,
              dueDate: (pickedDate.value.day == DateTime.now().day ||
                      pickedDate.value.day < DateTime.now().day)
                  ? null
                  : DateFormat("yyyy-MM-ddThh:mm:ss.ssssss")
                      .format(pickedDate.value),
              members: members,
            );
        attachmentsProvider.hasAttachments()
            ? attachmentsProvider.uploadTaskAttachment(taskId: model.id)
            : null;

        Future.delayed(
          Duration.zero,
          () => NavigationService.navigateTo(
            context,
            Pages.tasks,
          ),
        );
      }
    } catch (e) {
      throw Failure(e.toString());
    } finally {
      changeSubmitButton(true);
    }
  }
}
