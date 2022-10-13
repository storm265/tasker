import 'package:flutter/cupertino.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/base_tasks_controller.dart';

class ViewTaskController extends BaseTasksController {
  ViewTaskController({
    required super.taskValidator,
    required super.projectController,
    required super.attachmentsProvider,
    required super.secureStorage,
    required super.panelProvider,
    required super.memberProvider,
    required super.taskRepository,
  });

  bool isShowComments = false;
  final commentController = TextEditingController();
}
