import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/database/model/task_models/task_model.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/auth/widgets/unfocus_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/task_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/confirm_button.dart';
import 'package:todo2/presentation/pages/menu_pages/task/detailed_page/atachment_message_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/detailed_page/widgets/comment_button.dart';
import 'package:todo2/presentation/pages/menu_pages/task/detailed_page/widgets/detailed_item_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/detailed_page/widgets/icon_panel.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/presentation/widgets/common/disabled_scroll_glow_widget.dart';

class DetailedTaskPage extends StatefulWidget {
  final TaskModel pickedTask;
  final AddTaskController taskController;
  const DetailedTaskPage({
    Key? key,
    required this.taskController,
    required this.pickedTask,
  }) : super(key: key);
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
    return AlertDialog(
      titlePadding: const EdgeInsets.all(0),
      insetPadding: const EdgeInsets.all(25),
      contentPadding: const EdgeInsets.all(0),
      content: UnfocusWidget(
        child: SizedBox(
          width: 360,
          height: 700,
          child: DisabledGlowWidget(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const IconPanelWidget(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              widget.pickedTask.title,
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w200,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ),
                        ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) => Container(
                                  width: double.infinity,
                                  height: 2, //0.7
                                  color: const Color(0xFFE4E4E4),
                                ),
                            shrinkWrap: true,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              switch (index) {
                                case 0:
                                  // TODO fetch user name
                                  return DetailedItemWidget(
                                    leading: const CircleAvatar(
                                      backgroundColor: Colors.red,
                                      radius: 20,
                                    ),
                                    title: LocaleKeys.assigned_to.tr(),
                                    subtitle: 'Stephen Chow',
                                  );

                                case 1:
                                  return DetailedItemWidget(
                                    imageIcon: 'calendar',
                                    title: LocaleKeys.due_date.tr(),
                                    subtitle:
                                        '${widget.pickedTask.dueDate.year} ${widget.pickedTask.dueDate.day},${DateFormat('MMM').format(widget.pickedTask.dueDate)}', // widget.pickedTask.title,
                                  );

                                case 2:
                                  return DetailedItemWidget(
                                    isBlackColor: true,
                                    imageIcon: 'description',
                                    title: LocaleKeys.description.tr(),
                                    subtitle: widget.pickedTask.description,
                                  );

                                case 3:
                                  return DetailedItemWidget(
                                    imageIcon: 'members',
                                    title: LocaleKeys.members.tr(),
                                    customSubtitle: Row(
                                      children: [
                                        SizedBox(
                                          height: 30,
                                          width: 200,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                widget.pickedTask.members ==
                                                        null
                                                    ? widget.pickedTask.members
                                                        ?.length
                                                    : 0,
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
                                                      padding: EdgeInsets.only(
                                                        top: 2,
                                                        left: 2,
                                                        right: 2,
                                                      ),
                                                      child: CircleAvatar(
                                                        radius: 15,
                                                        backgroundColor:
                                                            Colors.red,
                                                      ),
                                                    );
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  );
// TODo fetch
                                case 4:
                                  return DetailedItemWidget(
                                    imageIcon: 'tag',
                                    title: LocaleKeys.tag.tr(),
                                    customSubtitle: Padding(
                                      padding: const EdgeInsets.only(
                                        right: 150,
                                      ),
                                      child: Container(
                                        height: 30,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            color: Colors.grey.withOpacity(0.5),
                                            width: 1,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Personal',
                                            style: TextStyle(
                                              color: getAppColor(
                                                color: CategoryColor.blue,
                                              ),
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );

                                default:
                                  return const Spacer();
                              }
                            }),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ValueListenableBuilder<bool>(
                    valueListenable:
                        widget.taskController.isSubmitButtonClicked,
                    builder: (_, isClicked, __) => ConfirmButtonWidget(
                      color: getAppColor(color: CategoryColor.blue),
                      title: LocaleKeys.complete_task.tr(),
                      onPressed: isClicked
                          ? () async {
                              await Future.delayed(const Duration(seconds: 2));
                            }
                          : null,
                    ),
                  ),

                  // AttachementWidget(taskController: widget.taskController),
                  CommentButton(onClickedCallback: () {})
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
