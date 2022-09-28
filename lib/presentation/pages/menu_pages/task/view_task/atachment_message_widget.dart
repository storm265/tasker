import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/database/model/task_models/task_model.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/task_controller.dart';

class AttachementWidget extends StatefulWidget {
  final AddTaskController taskController;
  final TaskModel pickedModel;
  const AttachementWidget({
    Key? key,
    required this.taskController,
    required this.pickedModel,
  }) : super(key: key);

  @override
  State<AttachementWidget> createState() => _AttachementWidgetState();
}

class _AttachementWidgetState extends State<AttachementWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: widget.pickedModel.attachments == null
            ? 0
            : widget.pickedModel.attachments?.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          int daysAgo = DateTime.now()
              .difference(widget.pickedModel.attachments![index].createdAt)
              .inDays;
          return Column(
            children: [
              ListTile(
                leading: const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.amber,
                ),
                title: const Text(
                  'title',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w200,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                subtitle: Text(
                  daysAgo.toString().length == 1
                      ? '$daysAgo ${LocaleKeys.day_ago.tr()}'
                      : '$daysAgo ${LocaleKeys.days_ago.tr()}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ),
              widget.pickedModel.attachments![index].type == "IMAGE"
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Container(
                        width: 300,
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  widget.pickedModel.attachments![index].url)),
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    )
                  : const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.file_present,
                        size: 40,
                        color: Colors.grey,
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }
}
