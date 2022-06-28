import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_note/widgets/add_user_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_note/widgets/description_field_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_note/widgets/for_in_field_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_note/widgets/title_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_task/widgets/fake_nav_bar.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_task/widgets/pick_time_field_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/confirm_button.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/red_app_bar.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/white_box_widget.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/services/theme_service/theme_data_controller.dart';
import 'package:todo2/presentation/widgets/common/will_pop_scope_wrapper.dart';

class SelectUserWidget extends StatelessWidget {
  const SelectUserWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color(0xFFF4F4F4),
        // color: Colors.red,
      ),
      height: 500,
      width: 365,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 3,
        shrinkWrap: true,
        itemBuilder: ((_, index) {
          return const ListTile(
            leading: CircleAvatar(),
            title: Text('FJIEJFIeif'),
            subtitle: Text('Stephenchow@company.com'),
          );
        }),
      ),
    );
  }
}

class NewTaskPage extends StatefulWidget {
  const NewTaskPage({Key? key}) : super(key: key);

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  final _forTextController = TextEditingController(text: 'Assignee');
  final _inTextController = TextEditingController(text: 'Project');

  @override
  void dispose() {
    _forTextController.dispose();
    _inTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWrapper(
      child: AppbarWrapperWidget(
        appBarColor: Palette.red,
        textColor: Colors.white,
        title: 'New Task',
        showLeadingButton: true,
        shouldUsePopMethod: true,
        child: Stack(
          children: [
            redAppBar,
            fakeNavBar,
            GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                newTaskController.showProjectWidget(false);
                newTaskController.showPickUserWidget(false);
              },
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
                            titleController: _forTextController,
                            text: 'For',
                          ),
                          EnterUserWidget(
                            titleController: _inTextController,
                            text: 'In',
                          )
                        ],
                      ),
                    ),
                    ValueListenableBuilder<bool>(
                        valueListenable: newTaskController.isShowPickUserWidget,
                        builder: (_, value, __) {
                          return value
                              ? const SelectUserWidget()
                              : Column(
                                  children: [
                                    const TitleWidget(),
                                    const DescriptionFieldWidget(),
                                    const PickTimeFieldWidget(),
                                    const AddUserWidget(),
                                    ConfirmButtonWidget(
                                      onPressed: () =>
                                          NavigationService.navigateTo(
                                        context,
                                        Pages.taskList,
                                      ),
                                      title: 'Add Task',
                                    ),
                                  ],
                                );
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
