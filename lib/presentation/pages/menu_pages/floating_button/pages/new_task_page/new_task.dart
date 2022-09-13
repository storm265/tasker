import 'package:flutter/material.dart';
import 'package:todo2/database/repository/task_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/note_page/widgets/add_member_widget/add_member_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/note_page/widgets/description_field_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/note_page/widgets/for_in_field_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/note_page/widgets/title_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/add_task_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/controller_inherited.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/fake_nav_bar.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/pick_time_field_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/selected_panel_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/confirm_button.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/red_app_bar.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/white_box_widget.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/presentation/widgets/common/progress_indicator_widget.dart';

class MyMode {
  int id;
  DateTime date;
  MyMode({required this.id, required this.date});
}

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
    return AppbarWrapWidget(
      title: 'New Task',
      resizeToAvoidBottomInset: false,
      showLeadingButton: true,
      isPopFromNavBar: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          List<MyMode> numbers = [
            MyMode(id: 5, date: DateTime.utc(2022, 11, 01)),
            MyMode(id: 9, date: DateTime.utc(2022, 01, 01)),
            MyMode(id: 1, date: DateTime.utc(2022, 04, 04)),
            MyMode(id: 3, date: DateTime.utc(2022, 05, 11)),
          ];
          numbers.sort((a, b) => b.date.compareTo(a.date));
          for (var i = 0; i < numbers.length; i++) {
            print(numbers[i].date);
          }
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
                          onChanged: (value) async {
                            await Future.delayed(
                                const Duration(milliseconds: 500),
                                () => setState(() {}));
                          },
                          titleController: newTaskController.userTextController,
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
                                  descriptionController: descriptionController,
                                ),
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
                                                      .validate(
                                                    context: context,
                                                    title: titleController.text,
                                                    description:
                                                        descriptionController
                                                            .text,
                                                  );
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
