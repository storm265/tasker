import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/auth/widgets/unfocus_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/add_task_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/panel_provider.dart';
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
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/presentation/widgets/common/activity_indicator_widget.dart';
import 'package:todo2/schemas/database_scheme/task_schemes/task_scheme.dart';
import 'package:todo2/services/dependency_service/dependency_service.dart';

class AddEditTaskPage extends StatefulWidget {
  const AddEditTaskPage({Key? key}) : super(key: key);

  @override
  State<AddEditTaskPage> createState() => _AddEditTaskPageState();
}

class _AddEditTaskPageState extends State<AddEditTaskPage> {
  final addEditTaskController = getIt<AddEditTaskController>();

  @override
  void initState() {
    addEditTaskController.getAccessToken();
    addEditTaskController.getOwnerId();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    final model = arguments == null ? null : arguments as Map<String, dynamic>;

    if (arguments == null) {
      addEditTaskController.isEditMode = false;
    } else {
      addEditTaskController.isEditMode = true;
      addEditTaskController.getEditData(
        assignedTo: model![TaskScheme.assignedTo],
        id: model[TaskScheme.id],
        description: model[TaskScheme.description],
        dueDate: model[TaskScheme.dueDate],
        members: model[TaskScheme.members],
        createdAt: model[TaskScheme.createdAt],
        ownerId: model[TaskScheme.ownerId],
        projectId: model[TaskScheme.projectId],
        title: model[TaskScheme.title],
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
      isPopFromNavBar: false,
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
                callback: () {
                  addEditTaskController.panelProvider
                      .changePanelStatus(newStatus: PanelStatus.hide);
                  FocusScope.of(context).unfocus();
                },
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
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: ValueListenableBuilder<bool>(
                                      valueListenable: addEditTaskController
                                          .isActiveSubmitButton,
                                      builder: (_, isClicked, __) => isClicked
                                          ? ConfirmButtonWidget(
                                              width: 310,
                                              title: addEditTaskController
                                                      .isEditMode
                                                  ? LocaleKeys.update_task.tr()
                                                  : LocaleKeys.add_task.tr(),
                                              onPressed: isClicked
                                                  ? () async {
                                                      addEditTaskController
                                                              .isEditMode
                                                          ? await addEditTaskController
                                                              .updateTask(
                                                                  context)
                                                          : await addEditTaskController
                                                              .createTask(
                                                                  context);
                                                    }
                                                  : null,
                                            )
                                          : ActivityIndicatorWidget(
                                              text: LocaleKeys.validating.tr(),
                                            ),
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
