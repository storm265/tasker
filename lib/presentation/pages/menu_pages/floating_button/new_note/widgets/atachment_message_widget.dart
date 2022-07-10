import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_task/controller/controller_inherited.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/widgets/panel_widgets/image_widget.dart';

class AttachementWidget extends StatelessWidget {
  const AttachementWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newTaskController =
        InheritedNewTaskController.of(context).addTaskController;
    return ValueListenableBuilder<List<PlatformFile>>(
      valueListenable: newTaskController.files,
      builder: (context, imgList, value) => FutureBuilder<List<String>>(
        //   future: newTaskController.fetchCommentInfo(),
        initialData: const [],
        builder: ((context, AsyncSnapshot<List<String>> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final dateNow = DateTime.now();

                return Column(
                  children: [
                    ListTile(
                      leading: CachedAvatarWidget(
                        radius: 40,
                        image: snapshot.data![index],
                      ),
                      title: Text(snapshot.data![1]),
                      subtitle: Text(
                          '${dateNow.day}/${dateNow.month}/${dateNow.year}'),
                    ),
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
              itemCount: newTaskController.files.value.length,
              shrinkWrap: true,
            );
          } else {
            return const CircularProgressIndicator.adaptive();
          }
        }),
      ),
    );
  }
}
