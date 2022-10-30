// ignore_for_file: use_build_context_synchronously
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/database/data_source/projects_data_source.dart';
import 'package:todo2/database/data_source/task_data_source.dart';
import 'package:todo2/database/data_source/user_data_source.dart';
import 'package:todo2/database/model/task_models/task_model.dart';
import 'package:todo2/database/repository/projects_repository.dart';
import 'package:todo2/database/repository/task_repository.dart';
import 'package:todo2/database/repository/user_repository.dart';
import 'package:todo2/database/scheme/projects/project_dao.dart';
import 'package:todo2/database/scheme/projects/project_database.dart';
import 'package:todo2/database/scheme/tasks/task_dao.dart';
import 'package:todo2/database/scheme/tasks/task_database.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/member_provider.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/description_widgets/task_attachaments_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/task_list.dart';
import 'package:todo2/presentation/providers/file_provider.dart';
import 'package:todo2/presentation/pages/auth/widgets/unfocus_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/attachments_provider.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/description_widgets/description_box_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/common_widgets/confirm_button.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/access_token_mixin.dart';
import 'package:todo2/presentation/pages/menu_pages/task/view_task/widgets/attachments/comment_attachment_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/view_task/widgets/attachments/task_attachament_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/view_task/controller/view_task_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/task/view_task/widgets/comment_button.dart';
import 'package:todo2/presentation/pages/menu_pages/task/view_task/widgets/detailed/detailed_title_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/view_task/widgets/icon_panel.dart';
import 'package:todo2/presentation/pages/menu_pages/task/view_task/widgets/items_widget.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/presentation/widgets/common/disabled_scroll_glow_widget.dart';
import 'package:todo2/services/cache_service/cache_service.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/storage/secure_storage_service.dart';

class ViewTask extends StatefulWidget with AccessTokenMixin {
  final TaskList taskController;
  final TaskModel pickedTask;
  const ViewTask({
    Key? key,
    required this.taskController,
    required this.pickedTask,
  }) : super(key: key);
  @override
  State<ViewTask> createState() => _ViewTaskState();
}

class _ViewTaskState extends State<ViewTask> {
  final viewTaskController = ViewTaskController(
    memberProvider: MemberProvider(),
    taskRepository: TaskRepositoryImpl(
      inMemoryCache: InMemoryCache(),
      taskDao: TaskDaoImpl(
        TaskDatabase(),
      ),
      taskDataSource: TaskDataSourceImpl(
        network: NetworkSource(),
        secureStorage: SecureStorageSource(),
      ),
    ),
    projectRepository: ProjectRepositoryImpl(
      inMemoryCache: InMemoryCache(),
      projectDao: ProjectDaoImpl(ProjectDatabase()),
      projectDataSource: ProjectUserDataImpl(
        secureStorageService: SecureStorageSource(),
        network: NetworkSource(),
      ),
    ),
    userRepository: UserProfileRepositoryImpl(
      userProfileDataSource: UserProfileDataSourceImpl(
        secureStorageService: SecureStorageSource(),
        network: NetworkSource(),
      ),
    ),
    secureStorage: SecureStorageSource(),
    attachmentsProvider: AttachmentsProvider(
      taskRepository: TaskRepositoryImpl(
        inMemoryCache: InMemoryCache(),
        taskDao: TaskDaoImpl(
          TaskDatabase(),
        ),
        taskDataSource: TaskDataSourceImpl(
          network: NetworkSource(),
          secureStorage: SecureStorageSource(),
        ),
      ),
      fileProvider: FileProvider(),
    ),
  );

  @override
  void initState() {
    viewTaskController.fetchInitialData(
      projectId: widget.pickedTask.projectId,
      assignedTo: widget.pickedTask.assignedTo,
      callback: () => setState(() {}),
      pickedTask: widget.pickedTask,
    );
    super.initState();
  }

  @override
  void dispose() {
    viewTaskController.commentController.dispose();
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
                    viewTaskController: viewTaskController,
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
                          viewTaskController: viewTaskController,
                        ),
                        const SizedBox(height: 20),
                        viewTaskController.isShowComments
                            ? Column(
                                children: [
                                  TaskAttachementWidget(
                                    viewTaskController: viewTaskController,
                                    pickedTask: widget.pickedTask,
                                  ),
                                  DescriptionBoxWidget(
                                    callback: () => setState(() {}),
                                    withImageIcon: true,
                                    viewTaskController: viewTaskController,
                                    textController:
                                        viewTaskController.commentController,
                                    attachmentsProvider:
                                        viewTaskController.attachmentsProvider,
                                    pickedTask: widget.pickedTask,
                                    hintText: LocaleKeys.write_a_comment.tr(),
                                  ),
                                  TaskAttachmentsWidget(
                                    attachmentsProvider:
                                        viewTaskController.attachmentsProvider,
                                  ),
                                  CommentAttachmentWidget(
                                    pickedTask: widget.pickedTask,
                                    viewTaskController: viewTaskController,
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
                              viewTaskController.isActiveSubmitButton,
                          builder: (_, isClicked, __) => Padding(
                            padding: viewTaskController.isShowComments
                                ? const EdgeInsets.symmetric(vertical: 36)
                                : const EdgeInsets.all(0),
                            child: ConfirmButtonWidget(
                              width: 320,
                              color: getAppColor(color: CategoryColor.blue),
                              title: LocaleKeys.complete_task.tr(),
                              onPressed: isClicked
                                  ? () async {
                                      final updatedModel =
                                          await viewTaskController.updateTask(
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
                  !viewTaskController.isShowComments
                      ? CommentButton(
                          onClickedCallback: () => setState(() {
                            viewTaskController.isShowComments =
                                !viewTaskController.isShowComments;
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
