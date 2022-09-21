import 'package:flutter/material.dart';
import 'package:todo2/database/repository/task_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/pick_time_dialog.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/note_page/widgets/add_member_widget/add_member_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/note_page/widgets/description_widgets/description_field_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/note_page/widgets/for_in_field_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/note_page/widgets/title_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/task_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/controller_inherited.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/fake_nav_bar.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/pick_time_field_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/selected_panel_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/confirm_button.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/red_app_bar.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/white_box_widget.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/presentation/widgets/common/progress_indicator_widget.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  // @override
  // void dispose() {
  //     newTaskController.titleController.dispose();
  //     newTaskController.descriptionController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final newTaskController =
        InheritedNewTaskController.of(context).addTaskController;
    return AppbarWrapWidget(
      title: 'New Task',
      resizeToAvoidBottomInset: false,
      showLeadingButton: true,
      isPopFromNavBar: true,
      navRoute: Pages.tasks,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // print('time ${DateTime.now()}');
          // print('time ${DateTime.now().toUtc()}');
          // print('time ${DateTime.now().toUtc().toIso8601String()}');
          pickTime(context: context);
        },
      ),
      child: Stack(
        children: [
          const FakeAppBar(),
          const FakeNavBarWidget(),
          Form(
            key: newTaskController.formKey,
            child: WhiteBoxWidget(
              onClick: () {
                FocusScope.of(context).unfocus();
                newTaskController.changePanelStatus(
                    newStatus: InputFieldStatus.hide);
              },
              height: 660,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        EnterUserWidget(
                          isForFieldActive: true,
                          onChanged: (_) async {
                            await Future.delayed(
                                const Duration(milliseconds: 500),
                                () => setState(() {}));
                          },
                          titleController: newTaskController.userTextController,
                          text: 'For',
                        ),
                        EnterUserWidget(
                          isForFieldActive: false,
                          onChanged: (_) async => await Future.delayed(
                              const Duration(milliseconds: 500),
                              () => setState(() {})),
                          titleController:
                              newTaskController.projectTextController,
                          text: 'In',
                        )
                      ],
                    ),
                  ),
                  ValueListenableBuilder<InputFieldStatus>(
                    valueListenable: newTaskController.panelStatus,
                    builder: (_, value, __) {
                      return (value != InputFieldStatus.hide)
                          // not updating if const
                          ? SelectPanelWidget()
                          : Column(
                              children: [
                                TaskTitleWidget(
                                  titleController:
                                      newTaskController.titleController,
                                ),
                                DescriptionFieldWidget(),
                                const PickTimeFieldWidget(),
                                const AddUserWidget(),
                                ValueListenableBuilder<bool>(
                                  valueListenable:
                                      newTaskController.isClickedAddTask,
                                  builder: (_, isClicked, __) => isClicked
                                      ? ConfirmButtonWidget(
                                          title: 'Add Task',
                                          onPressed: isClicked
                                              ? () async {
                                                  await newTaskController
                                                      .tryValidate(
                                                          context: context);
                                                }
                                              : null,
                                        )
                                      : const ProgressIndicatorWidget(
                                          text: 'Adding task ...'),
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
