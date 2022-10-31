import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/description_widgets/desciption_text_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/description_widgets/description_box_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/description_widgets/task_attachaments_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/base_tasks.dart';

class DescriptionFieldWidget extends StatelessWidget {
  final String? hintText;
  final int maxLength;
  final BaseTasks addEditTaskController;
  const DescriptionFieldWidget({
    Key? key,
    this.hintText,
    required this.addEditTaskController,
    this.maxLength = 512,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          desciptionTextWidget,
          DescriptionBoxWidget(
            attachmentsProvider: addEditTaskController.attachmentsProvider,
            textController: addEditTaskController.descriptionTextController,
            hintText: hintText,
          ),
          TaskAttachmentsWidget(
            attachmentsProvider: addEditTaskController.attachmentsProvider,
          )
        ],
      ),
    );
  }
}
