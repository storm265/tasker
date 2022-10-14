import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/database/data_source/projects_data_source.dart';
import 'package:todo2/database/data_source/user_data_source.dart';
import 'package:todo2/database/database_scheme/task_schemes/task_scheme.dart';
import 'package:todo2/database/repository/projects_repository.dart';
import 'package:todo2/database/repository/task_repository.dart';
import 'package:todo2/database/repository/user_repository.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/controller/file_provider.dart';
import 'package:todo2/presentation/pages/auth/widgets/unfocus_widget.dart';
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
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/presentation/widgets/common/progress_indicator_widget.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/storage/secure_storage_service.dart';

class AddEditTaskPage extends StatefulWidget {
  const AddEditTaskPage({Key? key}) : super(key: key);

  @override
  State<AddEditTaskPage> createState() => _AddEditTaskPageState();
}

class _AddEditTaskPageState extends State<AddEditTaskPage> {
  final addEditTaskController = AddEditTaskController(
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
    projectRepository: ProjectRepositoryImpl(
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
  );

  @override
  void initState() {
    addEditTaskController.getAccessToken();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    final mapped = arguments == null ? {} : arguments as Map<String, dynamic>;

    if (arguments == null) {
      addEditTaskController.isEditMode = false;
    } else {
      addEditTaskController.isEditMode = true;
      addEditTaskController.getEditData(
        assignedto: mapped[TaskScheme.assignedTo],
        projectId: mapped[TaskScheme.projectId],
        members: mapped[TaskScheme.members],
      );
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return AppbarWrapWidget(
      title: addEditTaskController.isEditMode
          ? LocaleKeys.update_task.tr()
          : LocaleKeys.new_task.tr(),
      resizeToAvoidBottomInset: false,
      showLeadingButton: true,
      navRoute: Pages.navigationReplacement,
      child: Stack(
        children: [
          const FakeAppBar(),
          const FakeNavBarWidget(),
          Form(
            key: addEditTaskController.formKey,
            child: WhiteBoxWidget(
              onClick: () {
                FocusScope.of(context).unfocus();
                addEditTaskController.panelProvider.changePanelStatus(
                  newStatus: PanelStatus.hide,
                );
              },
              height: 700,
              child: UnfocusWidget(
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
                            addEditTaskController: addEditTaskController,
                          ),
                          InFieldWidget(
                            addEditTaskController: addEditTaskController,
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
                          addEditTaskController.panelProvider.panelStatus,
                      builder: (_, value, __) {
                        return (value != PanelStatus.hide)
                            ? SelectPanelWidget(
                                addEditTaskController: addEditTaskController,
                              )
                            : Column(
                                children: [
                                  TaskTitleWidget(
                                    titleController: addEditTaskController
                                        .titleTextController,
                                  ),
                                  DescriptionFieldWidget(
                                    addEditTaskController:
                                        addEditTaskController,
                                  ),
                                  PickTimeFieldWidget(
                                    addEditTaskController:
                                        addEditTaskController,
                                  ),
                                  AddMemberWidget(
                                    addEditTaskController:
                                        addEditTaskController,
                                  ),
                                  ValueListenableBuilder<bool>(
                                    valueListenable: addEditTaskController
                                        .isActiveSubmitButton,
                                    builder: (_, isClicked, __) => isClicked
                                        ? ConfirmButtonWidget(
                                            title: LocaleKeys.add_task.tr(),
                                            onPressed: isClicked
                                                ? () async {
                                                    await addEditTaskController
                                                        .createTask(context);
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
          ),
        ],
      ),
    );
  }
}
