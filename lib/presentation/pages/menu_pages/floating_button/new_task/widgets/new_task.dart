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
import 'package:todo2/services/theme_service/theme_data_controller.dart';
import 'package:todo2/presentation/pages/navigation_page.dart';
import 'package:todo2/presentation/widgets/common/appbar_widget.dart';
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

  bool showPickUserWidget = false;
  @override
  Widget build(BuildContext context) {
    return WillPopWrapper(
      child: Scaffold(
        appBar: const AppbarWidget(
          appBarColor: Palette.red,
          textColor: Colors.white,
          title: 'New Task',
          showLeadingButton: true,
          shouldUsePopMethod: true,
        ),
        body: Stack(
          children: [
            redAppBar,
            fakeNavBar,
            WhiteBoxWidget(
              height: 570,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      EnterUserWidget(
                        titleController: _forTextController,
                        text: 'For',
                        showPickUserWidget: showPickUserWidget,
                      ),
                      EnterUserWidget(
                        titleController: _inTextController,
                        text: 'In',
                        showPickUserWidget: showPickUserWidget,
                      )
                    ],
                  ),
                  showPickUserWidget
                      ? const SelectUserWidget()
                      : Column(
                          children: [
                            //title text field
                            const TitleWidget(),
                            const DescriptionFieldWidget(),
                            const PickTimeFieldWidget(),
                            const AddUserWidget(),
                            ConfirmButtonWidget(
                              onPressed: () => pageController.jumpToPage(0),
                              title: 'Add Task',
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
