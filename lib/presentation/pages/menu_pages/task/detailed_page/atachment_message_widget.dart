import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/task_controller.dart';
import 'package:todo2/presentation/widgets/common/progress_indicator_widget.dart';

class AttachementWidget extends StatefulWidget {
  final AddTaskController taskController;
  const AttachementWidget({
    Key? key,
    required this.taskController,
  }) : super(key: key);

  @override
  State<AttachementWidget> createState() => _AttachementWidgetState();
}

class _AttachementWidgetState extends State<AttachementWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<PlatformFile>>(
      valueListenable: widget.taskController.attachments,
      builder: (context, imgList, value) => FutureBuilder<List<String>>(
        // future: newTaskController.fetchCommentInfo(),

        initialData: const [],
        builder: ((context, AsyncSnapshot<List<String>> snapshot) {
          if (!snapshot.hasData) {
            return ProgressIndicatorWidget(
              text: LocaleKeys.no_data.tr(),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final dateNow = DateTime.now();

                return Column(
                  children: [
                    // ListTile(
                    //   leading: CachedAvatarWidget(
                    //     radius: 40,
                    //     image: snapshot.data![index],
                    //   ),
                    //   title: Text(userName),
                    //   subtitle: Text(
                    //       '${dateNow.day}/${dateNow.month}/${dateNow.year}'),
                    // ),
                    imgList[index].path!.contains('.jpg') ||
                            imgList[index].path!.contains('.jpg')
                        ? Container(
                            width: 300,
                            height: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(
                                  File(imgList[index].path ?? ''),
                                ),
                              ),
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          )
                        : Column(
                            children: [
                              const Icon(
                                Icons.file_present,
                                size: 40,
                                color: Colors.grey,
                              ),
                              Text(imgList[index].name)
                            ],
                          )
                  ],
                );
              },
              itemCount: widget.taskController.attachments.value.length,
              shrinkWrap: true,
            );
          } else {
            return const ProgressIndicatorWidget();
          }
        }),
      ),
    );
  }
}
