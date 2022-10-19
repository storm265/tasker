import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/attachments_provider.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';

class TaskAttachmentsWidget extends StatelessWidget {
  final AttachmentsProvider attachmentsProvider;
  const TaskAttachmentsWidget({
    super.key,
    required this.attachmentsProvider,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<PlatformFile>>(
        valueListenable: attachmentsProvider.attachments,
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
                            onPressed: (_) =>
                                attachmentsProvider.removeAttachment(i),
                            icon: Icons.delete,
                            backgroundColor: Colors.red,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Chip(
                            avatar: attachmentsProvider.fileProvider
                                    .isValidImageFormat(imgList[i].path ?? '')
                                ? CircleAvatar(
                                    radius: 25,
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
                            label: LimitedBox(
                              maxWidth: 200,
                              child: Text(
                                imgList[i].name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 12,
                                ),
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
        });
  }
}
