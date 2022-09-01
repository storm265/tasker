import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/add_task_controller.dart';

class InheritedNewTaskController extends InheritedWidget {
  const InheritedNewTaskController({
    Key? key,
    required this.child,
    required this.addTaskController,
  }) : super(key: key, child: child);

  // ignore: overridden_fields, annotate_overrides
  final Widget child;
  final AddTaskController addTaskController;

  static InheritedNewTaskController of(BuildContext context) {
    final InheritedNewTaskController? result =
        context.dependOnInheritedWidgetOfExactType<InheritedNewTaskController>();
    assert(result != null, 'No ProfileInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(InheritedNewTaskController oldWidget) {
    return addTaskController != oldWidget.addTaskController;
  }
}
