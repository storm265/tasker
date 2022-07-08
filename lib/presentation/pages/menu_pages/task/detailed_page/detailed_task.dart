import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_task/controller/add_task_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_task/controller/controller_inherited.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_task/widgets/fake_nav_bar.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/confirm_button.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/red_app_bar.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/white_box_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/detailed_page/widgets/detailed_item_widget.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/presentation/widgets/common/will_pop_scope_wrapper.dart';

class DetailedTaskPage extends StatefulWidget {
  const DetailedTaskPage({Key? key}) : super(key: key);

  @override
  State<DetailedTaskPage> createState() => _DetailedTaskPageState();
}

class _DetailedTaskPageState extends State<DetailedTaskPage> {
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
        title: '',
        showLeadingButton: false,
        showAppBar: false,
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
              const FakeNavBarWidget(),
              Form(
                key: newTaskController.formKey,
                child: WhiteBoxWidget(
                  height: 620,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {}, icon: const Icon(Icons.close)),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.settings),
                          ),
                        ],
                      ),
                      const Text(
                        'Meeting according with design team in Central Park',
                        style: TextStyle(
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      ListView.separated(
                          separatorBuilder: (context, index) => Container(
                                width: double.infinity,
                                height: 0.7,
                                color: Colors.grey,
                              ),
                          shrinkWrap: true,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            switch (index) {
                              case 0:
                                return DetailedItemWidget(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.red,
                                    radius: 20,
                                  ),
                                  title: 'Assigned to',
                                  subtitle: 'Stephen Chow',
                                );

                              case 1:
                                return DetailedItemWidget(
                                  imageIcon: 'calendar',
                                  title: 'Due Date',
                                  subtitle: 'Aug 5,2018',
                                );

                              case 2:
                                return DetailedItemWidget(
                                  isBlackColor: true,
                                  imageIcon: 'description',
                                  title: 'Decription',
                                  subtitle:
                                      'Lorem ipsum dolor sit amet, consectetur adipiscing.',
                                );

                              case 3:
                                return DetailedItemWidget(
                                  imageIcon: 'members',
                                  title: 'Members',
                                  customSubtitle: Row(
                                    children: [
                                      SizedBox(
                                        height: 30,
                                        width: 200,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: 5,
                                            itemBuilder: (context, index) {
                                              return index == 4
                                                  ? const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 2),
                                                      child: CircleAvatar(
                                                        radius: 15,
                                                        backgroundColor:
                                                            Colors.red,
                                                        child: Icon(
                                                            Icons.more_horiz),
                                                      ),
                                                    )
                                                  : const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 2),
                                                      child: CircleAvatar(
                                                        radius: 15,
                                                        backgroundColor:
                                                            Colors.red,
                                                      ),
                                                    );
                                            }),
                                      )
                                    ],
                                  ),
                                );

                              case 4:
                                return DetailedItemWidget(
                                  imageIcon: 'tag',
                                  title: 'Tag',
                                  customSubtitle: Container(
                                    width: 90,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 2,
                                      ),
                                    ),
                                    child: Center(
                                        child: Text(
                                      'Personal',
                                      style: TextStyle(
                                        color: colors[0],
                                        fontStyle: FontStyle.italic,
                                      ),
                                    )),
                                  ),
                                );

                              default:
                                return const Spacer();
                            }
                          }),
                      const SizedBox(height: 20),
                      ValueListenableBuilder<bool>(
                        valueListenable: newTaskController.isClickedAddTask,
                        builder: (_, isClicked, __) => ConfirmButtonWidget(
                          color: colors[0],
                          title: 'Complete Task',
                          onPressed: isClicked
                              ? () async {
                                  newTaskController.validate(
                                    context: context,
                                    title: titleController.text,
                                    description: descriptionController.text,
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
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Comments',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 17,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 7),
                              child: Image.asset(
                                  'assets/detailed_task/double_arrow.png'),
                            )
                          ],
                        ),
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
