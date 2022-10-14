import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/database/model/task_models/task_model.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/menu_pages/task/view_task/controller/view_task_controller.dart';

class TaskAttachementWidget extends StatelessWidget {
  final ViewTaskController viewTaskController;
  final TaskModel pickedModel;
  const TaskAttachementWidget({
    Key? key,
    required this.viewTaskController,
    required this.pickedModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log('ss ${viewTaskController.user?.avatarUrl}');
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ListView.builder(
        itemCount: pickedModel.attachments == null
            ? 0
            : pickedModel.attachments?.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) {
          int daysAgo = DateTime.now()
              .difference(pickedModel.attachments![index].createdAt)
              .inDays;
          return Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    viewTaskController.user?.avatarUrl ?? '',
                    headers: viewTaskController.imageHeader,
                  ),
                  radius: 20,
                  backgroundColor: Colors.amber,
                ),
                title: Text(
                  viewTaskController.user?.username ?? '',
                  style: const TextStyle(
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
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ),
              pickedModel.attachments![index].type == "IMAGE"
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        pickedModel.attachments![index].url,
                        headers: viewTaskController.imageHeader,
                      ),
                    )
                  : Column(
                      children: [
                        const Icon(
                          Icons.file_present,
                          size: 40,
                          color: Colors.grey,
                        ),
                        Text(
                          pickedModel.attachments![index].name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
            ],
          );
        },
      ),
    );
  }
}
