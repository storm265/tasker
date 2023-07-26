// ignore_for_file: use_build_context_synchronously
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/domain/model/task_models/task_model.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/description_widgets/task_attachaments_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/task_list.dart';
import 'package:todo2/presentation/pages/auth/widgets/unfocus_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/description_widgets/description_box_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/common_widgets/confirm_button_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/secure_mixin.dart';
import 'package:todo2/presentation/pages/menu_pages/task/view_task/widgets/attachments/comment_attachment_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/view_task/widgets/attachments/task_attachament_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/view_task/controller/view_task_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/task/view_task/widgets/comment_button_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/view_task/widgets/detailed/detailed_title_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/view_task/widgets/icon_panel_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/view_task/widgets/items_widget.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/presentation/widgets/common/disabled_scroll_glow_widget.dart';
import 'package:todo2/services/dependency_service/dependency_service.dart';

class ViewTask extends StatefulWidget with SecureMixin {
  const ViewTask({
    Key? key,
    required this.taskController,
    required this.pickedTask,
  }) : super(key: key);

  final TaskList taskController;

  final TaskModel pickedTask;

  @override
  State<ViewTask> createState() => _ViewTaskState();
}

class _ViewTaskState extends State<ViewTask> {
  final _viewTaskController = getIt<ViewTaskController>();

  @override
  void initState() {
    _viewTaskController.fetchInitialData(
      projectId: widget.pickedTask.projectId,
      assignedTo: widget.pickedTask.assignedTo,
      callback: () => setState(() {}),
      pickedTask: widget.pickedTask,
    );
    super.initState();
  }

  @override
  void dispose() {
    _viewTaskController.commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      content: UnfocusWidget(
        child: SizedBox(
          width: 360,
          height: 740,
          child: DisabledGlowWidget(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconPanelWidget(
                    viewTaskController: _viewTaskController,
                    taskListController: widget.taskController,
                    selectedTask: widget.pickedTask,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Column(
                      children: [
                        DetailedTitleWidget(title: widget.pickedTask.title),
                        ItemsWidget(
                          pickedTask: widget.pickedTask,
                          viewTaskController: _viewTaskController,
                        ),
                        const SizedBox(height: 20),
                        _viewTaskController.isShowComments
                            ? Column(
                                children: [
                                  TaskAttachementWidget(
                                    viewTaskController: _viewTaskController,
                                    pickedTask: widget.pickedTask,
                                  ),
                                  DescriptionBoxWidget(
                                    callback: () => setState(() {}),
                                    withImageIcon: true,
                                    viewTaskController: _viewTaskController,
                                    textController:
                                        _viewTaskController.commentController,
                                    attachmentsProvider:
                                        _viewTaskController.attachmentsProvider,
                                    pickedTask: widget.pickedTask,
                                    hintText: LocaleKeys.write_a_comment.tr(),
                                  ),
                                  TaskAttachmentsWidget(
                                    attachmentsProvider:
                                        _viewTaskController.attachmentsProvider,
                                  ),
                                  CommentAttachmentWidget(
                                    pickedTask: widget.pickedTask,
                                    viewTaskController: _viewTaskController,
                                  )
                                ],
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                  widget.pickedTask.isCompleted != true &&
                          DateTime.now().isBefore(widget.pickedTask.dueDate)
                      ? ValueListenableBuilder<bool>(
                          valueListenable:
                              _viewTaskController.isActiveSubmitButton,
                          builder: (_, isClicked, __) => Padding(
                            padding: _viewTaskController.isShowComments
                                ? const EdgeInsets.symmetric(vertical: 36)
                                : const EdgeInsets.all(0),
                            child: ConfirmButtonWidget(
                              width: 320,
                              color: getAppColor(color: CategoryColor.blue),
                              title: LocaleKeys.complete_task.tr(),
                              onPressed: isClicked
                                  ? () async {
                                      final updatedModel =
                                          await _viewTaskController.updateTask(
                                        widget.pickedTask,
                                        context,
                                      );
                                      if (updatedModel.id.isNotEmpty) {
                                        widget.taskController
                                            .updateTaskItem(updatedModel);
                                        Navigator.pop(context);
                                      }
                                    }
                                  : null,
                            ),
                          ),
                        )
                      : const SizedBox(),
                  !_viewTaskController.isShowComments
                      ? CommentButtonWidget(
                          onClickedCallback: () => setState(() {
                            _viewTaskController.isShowComments =
                                !_viewTaskController.isShowComments;
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
