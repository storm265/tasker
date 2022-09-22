import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/add_member_widget/add_member_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/description_widgets/description_field_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/for_in_field_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/title_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/task_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/common/fake_nav_bar.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/date_widgets/pick_time_field_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/panels/selected_panel_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/confirm_button.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/red_app_bar.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/white_box_widget.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/presentation/widgets/common/progress_indicator_widget.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/storage/secure_storage_service.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final formKey = GlobalKey<FormState>();
  final taskController = AddTaskController();
  @override
  void initState() {
    taskController.getAccessHeader();
    log('imageHeader: ${taskController.imageHeader}');
    super.initState();
  }

  // @override
  // void dispose() {
  //   titleController.dispose();
  //   descriptionController.dispose();
  //   super.dispose();
  // }
  final _secureStorageService = SecureStorageSource();
  @override
  Widget build(BuildContext context) {
    return AppbarWrapWidget(
      floatingActionButton: FloatingActionButton(
          child: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://todolist.dev2.cogniteq.com/api/v1/users-avatar/fbd1792c-dfa4-4507-b3ff-5ea561c416e1',
                  headers: {
                'Authorization':
                    'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJodHRwOi8vMC4wLjAuMDo4MDgwLyIsImlzcyI6Imh0dHA6Ly8wLjAuMC4wOjgwODAvIiwiZXhwIjoxNjY0MDUzMjI1LCJlbWFpbCI6ImphamFAbWFpbC5ydSJ9.U-ZPTxH-bQ5gbdCxCsMstGU8MfyovK6Krnicsok41D4'
              })),
          onPressed: () async {
            final list = await taskController.taskMemberSearch(nickname: 'adr');
            //  taskController.taskMemberSearch(nickname: 'Adr');
            for (var i = 0; i < list.length; i++) {
              log('users ${list[i].username}');
            }
            print('toUtc -  ${taskController.pickedDate.value.toUtc()}');
            print(
                'toIso8601String -  ${taskController.pickedDate.value.toIso8601String()}');
            print(
                'toUtc().toString() -  ${taskController.pickedDate.value.toUtc().toString()}');
          }),
      title: 'New Task',
      resizeToAvoidBottomInset: false,
      showLeadingButton: true,
      isPopFromNavBar: true,
      navRoute: Pages.tasks,
      child: Stack(
        children: [
          const FakeAppBar(),
          const FakeNavBarWidget(),
          Form(
            key: formKey,
            child: WhiteBoxWidget(
              onClick: () {
                FocusScope.of(context).unfocus();
                taskController.changePanelStatus(
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
                          taskController: taskController,
                          isForFieldActive: true,
                          onChanged: (_) async {
                            await Future.delayed(const Duration(seconds: 1),
                                () => setState(() {}));
                          },
                          titleController: taskController.userTextController,
                          text: 'For',
                        ),
                        EnterUserWidget(
                          taskController: taskController,
                          isForFieldActive: false,
                          onChanged: (_) async => await Future.delayed(
                              const Duration(seconds: 1),
                              () => setState(() {})),
                          titleController: taskController.projectTextController,
                          text: 'In',
                        )
                      ],
                    ),
                  ),
                  ValueListenableBuilder<InputFieldStatus>(
                    valueListenable: taskController.panelStatus,
                    builder: (_, value, __) {
                      return (value != InputFieldStatus.hide)
                          // not updating if const
                          ? SelectPanelWidget()
                          : Column(
                              children: [
                                TaskTitleWidget(
                                  titleController:
                                      taskController.titleController,
                                ),
                                DescriptionFieldWidget(
                                  taskController: taskController,
                                ),
                                const PickTimeFieldWidget(),
                                AddUserWidget(
                                  taskController: taskController,
                                ),
                                ValueListenableBuilder<bool>(
                                  valueListenable:
                                      taskController.isClickedAddTask,
                                  builder: (_, isClicked, __) => isClicked
                                      ? ConfirmButtonWidget(
                                          title: 'Add Task',
                                          onPressed: isClicked
                                              ? () async {
                                                  await taskController
                                                      .tryValidate(
                                                    context: context,
                                                    formKey: formKey,
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
