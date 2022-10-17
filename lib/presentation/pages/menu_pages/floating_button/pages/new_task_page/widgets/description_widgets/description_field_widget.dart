import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/description_widgets/desciption_text_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/description_widgets/description_box_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/base_tasks_controller.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';

class DescriptionFieldWidget extends StatelessWidget {
  final String? hintText;
  final int maxLength;
  final BaseTasksController addEditTaskController;
  const DescriptionFieldWidget({
    Key? key,
    this.hintText,
    required this.addEditTaskController,
    this.maxLength = 512,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          desciptionTextWidget,
          DescriptionBoxWidget(
            attachmentsProvider: addEditTaskController.attachmentsProvider,
            textController: addEditTaskController.descriptionTextController,
            hintText: hintText,
          ),
          ValueListenableBuilder<List<PlatformFile>>(
              valueListenable:
                  addEditTaskController.attachmentsProvider.attachments,
              builder: (_, imgList, __) {
                if (imgList.isEmpty) {
                  return const SizedBox();
                } else {
                  return ListView.builder(
                    itemCount: imgList.length,
                    shrinkWrap: true,
                    itemBuilder: (_, i) {
                      return Wrap(
                        alignment: WrapAlignment.start,
                        children: [
                          Slidable(
                            key: const ValueKey(0),
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (_) => addEditTaskController
                                      .attachmentsProvider
                                      .removeAttachment(i),
                                  icon: Icons.delete,
                                  backgroundColor: Colors.red,
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Chip(
                                  avatar: addEditTaskController
                                          .attachmentsProvider.fileProvider
                                          .isValidImageFormat(
                                              imgList[i].path ?? '')
                                      ? CircleAvatar(
                                          radius: 20,
                                          backgroundImage: FileImage(
                                            File(imgList[i].path ?? ''),
                                          ),
                                        )
                                      : const Icon(
                                          Icons.file_present,
                                          color: Colors.white,
                                        ),
                                  backgroundColor:
                                      getAppColor(color: CategoryColor.blue),
                                  label: Text(
                                    imgList[i].name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    '${(imgList[i].size / 1024 / 1024).toStringAsFixed(3)} mb',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              }),
        ],
      ),
    );
  }
}
