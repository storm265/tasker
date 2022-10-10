import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/database/model/task_models/task_model.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/auth/splash_page.dart';
import 'package:todo2/presentation/pages/menu_pages/task/view_task/controller/view_task_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/task/view_task/widgets/detailed_item_widget.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/services/theme_service/theme_data_controller.dart';

class ItemsWidget extends StatefulWidget {
  final TaskModel pickedTask;
  final ViewTaskController viewTaskController;
  const ItemsWidget({
    super.key,
    required this.pickedTask,
    required this.viewTaskController,
  });

  @override
  State<ItemsWidget> createState() => _ItemsWidgetState();
}

class _ItemsWidgetState extends State<ItemsWidget> {
  @override
  void initState() {
    widget.viewTaskController.getAccessHeader();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (_, i) => Container(
              width: double.infinity,
              height: 1.25,
              color: const Color(0xFFE4E4E4),
            ),
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (_, i) {
          switch (i) {
            case 0:
              // TODO fetch user name
              return DetailedItemWidget(
                leading: const CircleAvatar(
                  backgroundColor: Colors.grey,
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
                    '${widget.pickedTask.dueDate.year} ${widget.pickedTask.dueDate.day},${DateFormat('MMM', locale).format(widget.pickedTask.dueDate)}', // widget.pickedTask.title,
              );

            case 2:
              return DetailedItemWidget(
                isBlackTextColor: true,
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
                        itemCount: widget.pickedTask.members == null
                            ? 0
                            : (widget.pickedTask.members!.length > 5)
                                ? 5
                                : widget.pickedTask.members?.length,
                        itemBuilder: (context, index) {
                          return index == 4
                              ? const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 2),
                                  child: CircleAvatar(
                                    radius: 15,
                                    backgroundColor: Palette.red,
                                    child: Icon(
                                      Icons.more_horiz,
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(
                                    top: 2,
                                    left: 1.25,
                                    right: 1.25,
                                  ),
                                  child: CircleAvatar(
                                    radius: 16,
                                    backgroundColor: Colors.grey,
                                    backgroundImage: NetworkImage(
                                      widget
                                          .pickedTask.members![index].avatarUrl,
                                      headers:
                                          widget.viewTaskController.imageHeader,
                                    ),
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
                    top: 5,
                  ),
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
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
                          fontWeight: FontWeight.w200,
                          fontSize: 16,
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
        });
  }
}
