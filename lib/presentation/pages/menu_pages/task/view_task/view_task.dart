import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/database/model/task_models/task_model.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/auth/widgets/unfocus_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/task_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/description_widgets/description_box_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/confirm_button.dart';
import 'package:todo2/presentation/pages/menu_pages/task/view_task/atachment_message_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/view_task/widgets/comment_button.dart';
import 'package:todo2/presentation/pages/menu_pages/task/view_task/widgets/detailed_title_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/view_task/widgets/icon_panel.dart';
import 'package:todo2/presentation/pages/menu_pages/task/view_task/widgets/items_widget.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/presentation/widgets/common/disabled_scroll_glow_widget.dart';

class ViewTask extends StatefulWidget {
  final TaskModel pickedTask;
  final AddTaskController taskController;
  const ViewTask({
    Key? key,
    required this.taskController,
    required this.pickedTask,
  }) : super(key: key);
  @override
  State<ViewTask> createState() => _ViewTaskState();
}

class _ViewTaskState extends State<ViewTask> {
  bool isShowComments = false;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log('picked Task ${widget.pickedTask.members?.length}');
    return AlertDialog(
      titlePadding: const EdgeInsets.all(0),
      insetPadding: const EdgeInsets.all(25),
      contentPadding: const EdgeInsets.all(0),
      content: UnfocusWidget(
        child: SizedBox(
          width: 360,
          height: 700,
          child: DisabledGlowWidget(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const IconPanelWidget(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Column(
                      children: [
                        DetailedTitleWidget(title: widget.pickedTask.title),
                        ItemsWidget(pickedTask: widget.pickedTask),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  isShowComments
                      ? DescriptionBoxWidget(
                          withImageIcon: true,
                          taskController: widget.taskController,
                        )
                      : const SizedBox(),
                  isShowComments
                      ? AttachementWidget(
                          pickedModel: widget.pickedTask,
                          taskController: widget.taskController,
                        )
                      : const SizedBox(),
                  ValueListenableBuilder<bool>(
                    valueListenable:
                        widget.taskController.isSubmitButtonClicked,
                    builder: (_, isClicked, __) => ConfirmButtonWidget(
                      color: getAppColor(color: CategoryColor.blue),
                      title: LocaleKeys.complete_task.tr(),
                      onPressed: isClicked
                          ? () async {
                              await Future.delayed(const Duration(seconds: 2));
                            }
                          : null,
                    ),
                  ),
                  !isShowComments
                      ? CommentButton(
                          onClickedCallback: () => setState(() {
                            log('message');
                            isShowComments = !isShowComments;
                          }),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
