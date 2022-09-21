import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo2/presentation/controller/image_picker_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/note_page/widgets/atachment_message_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/controller_inherited.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/note_page/widgets/description_widgets/desciption_text.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/note_page/widgets/description_widgets/description_text_field.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/presentation/widgets/common/slidable_widgets/endpane_widget.dart';
import 'package:todo2/utils/assets_path.dart';

class DescriptionFieldWidget extends StatelessWidget {
  final String? hintText;
  final int maxLength;
  DescriptionFieldWidget({
    Key? key,
    this.hintText,
    this.maxLength = 512,
  }) : super(key: key);

  final fileController = FileController();
  @override
  Widget build(BuildContext context) {
    final newTaskController =
        InheritedNewTaskController.of(context).addTaskController;
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
                  const DescriptionTextField(),
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
                                newTaskController.addAttachment(
                                    attachment: file);
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
              valueListenable: newTaskController.attachments,
              builder: (_, imgList, __) {
                print(
                  '${imgList[0].size / 1000}mb ',
                );
                if (imgList.isEmpty) {
                  return const SizedBox();
                } else {
                  return ListView.builder(
                    itemCount: newTaskController.attachments.value.length,
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
                                      newTaskController.removeAttachment(i),
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
