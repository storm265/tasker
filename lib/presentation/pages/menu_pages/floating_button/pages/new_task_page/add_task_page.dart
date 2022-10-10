import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/database/data_source/projects_data_source.dart';
import 'package:todo2/database/repository/projects_repository.dart';
import 'package:todo2/database/repository/task_repository.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/controller/file_provider.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/controller/color_pallete_controller/color_pallete_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/controllers/add_task_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/attachments_provider.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/member_provider.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/panel_provider.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/task_validator.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/add_member_widget/add_member_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/description_widgets/description_field_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/for_field_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/in_field_wdiget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/title_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/common/fake_nav_bar.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/date_widgets/pick_time_field_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/panels/selected_panel_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/common_widgets/confirm_button.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/common_widgets/red_app_bar.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/common_widgets/white_box_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/controller/project_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/base_tasks_controller.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/presentation/widgets/common/progress_indicator_widget.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/storage/secure_storage_service.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  late BaseTasksController baseTasksController;
  @override
  void initState() {
    // TODO: implement edit mode
    baseTasksController = AddEditTaskController(
      taskRepository: TaskRepositoryImpl(),
      memberProvider: MemberProvider(),
      projectController: ProjectController(
        colorPalleteController: ColorPalleteController(),
        projectsRepository: ProjectRepositoryImpl(
          projectDataSource: ProjectUserDataImpl(
            secureStorageService: SecureStorageSource(),
            network: NetworkSource(),
          ),
        ),
      ),
      panelProvider: PanelProvider(),
      taskValidator: TaskValidator(),
      attachmentsProvider: AttachmentsProvider(
        fileProvider: FileProvider(),
        taskRepository: TaskRepositoryImpl(),
      ),
      secureStorage: SecureStorageSource(),
    );
    baseTasksController.getAccessToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppbarWrapWidget(
      title: LocaleKeys.new_task.tr(),
      resizeToAvoidBottomInset: false,
      showLeadingButton: true,
      navRoute: Pages.tasks,
      child: Stack(
        children: [
          const FakeAppBar(),
          const FakeNavBarWidget(),
          Form(
            key: baseTasksController.formKey,
            child: WhiteBoxWidget(
              onClick: () {
                FocusScope.of(context).unfocus();
                baseTasksController.panelProvider.changePanelStatus(
                  newStatus: PanelStatus.hide,
                );
              },
              height: 700,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ForTextFieldWidget(
                          callback: () async => await Future.delayed(
                            const Duration(seconds: 1),
                            () => setState(
                              () {},
                            ),
                          ),
                          addEditTaskController: baseTasksController,
                        ),
                        InFieldWidget(
                          addEditTaskController: baseTasksController,
                          callback: () async => await Future.delayed(
                            const Duration(seconds: 1),
                            () => setState(
                              () {},
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ValueListenableBuilder<PanelStatus>(
                    valueListenable:
                        baseTasksController.panelProvider.panelStatus,
                    builder: (_, value, __) {
                      return (value != PanelStatus.hide)
                          ? SelectPanelWidget(
                              addEditTaskController: baseTasksController,
                            )
                          : Column(
                              children: [
                                TaskTitleWidget(
                                  titleController:
                                      baseTasksController.titleTextController,
                                ),
                                DescriptionFieldWidget(
                                  addEditTaskController: baseTasksController,
                                ),
                                PickTimeFieldWidget(
                                  addEditTaskController: baseTasksController,
                                ),
                                AddMemberWidget(
                                  addEditTaskController: baseTasksController,
                                ),
                                ValueListenableBuilder<bool>(
                                  valueListenable:
                                      baseTasksController.isActiveSubmitButton,
                                  builder: (_, isClicked, __) => isClicked
                                      ? ConfirmButtonWidget(
                                          title: LocaleKeys.add_task.tr(),
                                          onPressed: isClicked
                                              ? () async {
                                                  // await taskValidator
                                                  //     .tryValidate(
                                                  //   context: context,
                                                  // );
                                                }
                                              : null,
                                        )
                                      : ProgressIndicatorWidget(
                                          text: LocaleKeys.validating.tr(),
                                        ),
                                ),
                              ],
                            );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
