import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_note/widgets/add_member_widget/add_member_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_note/widgets/description_field_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_note/widgets/for_in_field_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_note/widgets/title_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_task/controller/add_task_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_task/controller/controller_inherited.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_task/widgets/fake_nav_bar.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_task/widgets/pick_time_field_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_task/widgets/selected_panel_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/confirm_button.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/red_app_bar.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/white_box_widget.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/presentation/widgets/common/will_pop_scope_wrapper.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
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
    final newTaskController =
        InheritedNewTaskController.of(context).addTaskController;
    return WillPopWrapper(
      child: AppbarWrapperWidget(
        title: 'New Task',
        showLeadingButton: true,
        shouldUsePopMethod: true,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            newTaskController.changePanelStatus(
                newStatus: InputFieldStatus.hide);
          },
          child: Stack(
            children: [
              redAppBar,
              fakeNavBar,
              Form(
                key: newTaskController.formKey,
                child: WhiteBoxWidget(
                  height: 570,
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
                              onChanged: (value) async {
                                await Future.delayed(
                                    const Duration(milliseconds: 500),
                                    () => setState(() {}));
                              },
                              titleController:
                                  newTaskController.userTextController,
                              text: 'For',
                            ),
                            EnterUserWidget(
                              isForFieldActive: false,
                              onChanged: (value) async => await Future.delayed(
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
                                    TitleWidget(
                                      titleController: titleController,
                                    ),
                                    DescriptionFieldWidget(
                                      descriptionController:
                                          descriptionController,
                                    ),
                                    const PickTimeFieldWidget(),
                                    const AddUserWidget(),
                                    ValueListenableBuilder<bool>(
                                      valueListenable:
                                          newTaskController.isClickedAddTask,
                                      builder: (_, isClicked, __) =>
                                          ConfirmButtonWidget(
                                        title: 'Add Task',
                                        onPressed: isClicked
                                            ? () async {
                                                newTaskController
                                                    .validate(
                                                      context: context,
                                                      title:
                                                          titleController.text,
                                                      description:
                                                          descriptionController
                                                              .text,
                                                    );
                                                    // without then
                                                    // .then((_) =>
                                                    //     NavigationService
                                                    //         .navigateTo(
                                                    //       context,
                                                    //       Pages.taskList,
                                                    //     ));
                                              }
                                            : null,
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
        ),
      ),
    );
  }
}
