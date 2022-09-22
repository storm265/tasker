import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo2/presentation/controller/image_picker_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/task_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/description_widgets/desciption_text.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/description_widgets/description_text_field.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';

class DescriptionFieldWidget extends StatelessWidget {
  final String? hintText;
  final int maxLength;
  final AddTaskController taskController;
  DescriptionFieldWidget({
    Key? key,
    this.hintText,
    required this.taskController,
    this.maxLength = 512,
  }) : super(key: key);

  final fileController = FileController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          desciptionTextWidget,
          Container(
            width: 290,
            height: 110,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFFEAEAEA),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DescriptionTextField(taskController: taskController),
                  Padding(
                    padding: const EdgeInsets.only(top: 23),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xFFEAEAEA), width: 1),
                        borderRadius: const BorderRadius.horizontal(
                            right: Radius.circular(5),
                            left: Radius.circular(5)),
                        color: const Color(0xFFF8F8F8),
                      ),
                      width: double.infinity,
                      height: 40,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Transform.rotate(
                          angle: 43.2,
                          child: IconButton(
                              icon: const Icon(
                                Icons.attachment_outlined,
                                color: Colors.grey,
                              ),
                              onPressed: () async {
                                final file = await fileController.pickFile(
                                    context: context);
                                taskController.addAttachment(attachment: file);
                              }),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //   const AttachementWidget(),
          ValueListenableBuilder<List<PlatformFile>>(
              valueListenable: taskController.attachments,
              builder: (_, imgList, __) {
                if (imgList.isEmpty) {
                  return const SizedBox();
                } else {
                  return ListView.builder(
                    itemCount: taskController.attachments.value.length,
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
                                  onPressed: (_) =>
                                      taskController.removeAttachment(i),
                                  icon: Icons.delete,
                                  backgroundColor: Colors.red,
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Chip(
                                  avatar: fileController.isValidImageFormat(
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
