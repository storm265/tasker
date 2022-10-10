import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/database/model/task_models/task_model.dart';
import 'package:todo2/database/repository/task_repository.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/controller/file_provider.dart';
import 'package:todo2/presentation/pages/auth/widgets/unfocus_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/attachments_provider.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/description_widgets/description_box_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/common_widgets/confirm_button.dart';
import 'package:todo2/presentation/pages/menu_pages/task/view_task/atachment_message_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/view_task/controller/view_task_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/task/view_task/widgets/comment_button.dart';
import 'package:todo2/presentation/pages/menu_pages/task/view_task/widgets/detailed_title_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/view_task/widgets/icon_panel.dart';
import 'package:todo2/presentation/pages/menu_pages/task/view_task/widgets/items_widget.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/presentation/widgets/common/disabled_scroll_glow_widget.dart';

class ViewTask extends StatefulWidget {
  final TaskModel pickedTask;
  const ViewTask({
    Key? key,
    required this.pickedTask,
  }) : super(key: key);
  @override
  State<ViewTask> createState() => _ViewTaskState();
}

class _ViewTaskState extends State<ViewTask> {
  bool isShowComments = false;
  final viewTaskController = ViewTaskController(
    attachmentsProvider: AttachmentsProvider(
      taskRepository: TaskRepositoryImpl(),
      fileProvider: FileProvider(),
    ),
  );

  @override
  void dispose() {
    viewTaskController.descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log('picked Task ${widget.pickedTask.members?.length}');
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      content: UnfocusWidget(
        child: SizedBox(
          width: 360,
          height: 700,
          child: DisabledGlowWidget(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconPanelWidget(
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
                          viewTaskController: viewTaskController,
                        ),
                        const SizedBox(height: 20),
                        isShowComments
                            ? DescriptionBoxWidget(
                                withImageIcon: true,
                                descriptionController:
                                    viewTaskController.descriptionController,
                                attachmentsProvider:
                                    viewTaskController.attachmentsProvider,
                                hintText: LocaleKeys.write_a_comment.tr(),
                              )
                            : const SizedBox(),
                        isShowComments
                            ? AttachementWidget(
                                pickedModel: widget.pickedTask,
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                  ValueListenableBuilder<bool>(
                    valueListenable: viewTaskController.isActiveSubmitButton,
                    builder: (_, isClicked, __) => Padding(
                      padding: isShowComments
                          ? const EdgeInsets.symmetric(vertical: 36)
                          : const EdgeInsets.all(0),
                      child: ConfirmButtonWidget(
                        width: 320,
                        color: getAppColor(color: CategoryColor.blue),
                        title: LocaleKeys.complete_task.tr(),
                        onPressed: isClicked
                            ? () async {
                                await Future.delayed(
                                    const Duration(seconds: 2));
                              }
                            : null,
                      ),
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
