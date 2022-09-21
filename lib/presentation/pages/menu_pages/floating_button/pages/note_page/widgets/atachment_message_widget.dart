import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:todo2/database/repository/user_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/controller_inherited.dart';

import 'package:todo2/presentation/pages/menu_pages/profile/widgets/panel_widgets/cached_avatar_widget.dart';
import 'package:todo2/presentation/widgets/common/progress_indicator_widget.dart';

class AttachementWidget extends StatefulWidget {
  const AttachementWidget({Key? key}) : super(key: key);

  @override
  State<AttachementWidget> createState() => _AttachementWidgetState();
}

class _AttachementWidgetState extends State<AttachementWidget> {
  late String userName;
  @override
  void initState() {
    fetchUserName();
    super.initState();
  }

  void fetchUserName() async {
    //userName = await UserProfileRepositoryImpl().fetchUserName();
  }

  @override
  Widget build(BuildContext context) {
    final newTaskController =
        InheritedNewTaskController.of(context).addTaskController;
    return ValueListenableBuilder<List<PlatformFile>>(
      valueListenable: newTaskController.attachments,
      builder: (context, imgList, value) => FutureBuilder<List<String>>(
        // future: newTaskController.fetchCommentInfo(),

        initialData: const [],
        builder: ((context, AsyncSnapshot<List<String>> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
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
              itemCount: newTaskController.attachments.value.length,
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
