import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_task/controller/add_task_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/widgets/panel_widgets/image_widget.dart';

class DescriptionFieldWidget extends StatelessWidget {
  const DescriptionFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              left: 30,
              bottom: 10,
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Description',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
          Container(
            width: 290,
            height: 110,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFFEAEAEA),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(5),
              color: const Color(0xFFF4F4F4),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 25,
                      top: 10,
                    ),
                    child: TextField(
                      maxLength: 512,
                      buildCounter: (context,
                              {required currentLength,
                              required isFocused,
                              maxLength}) =>
                          maxLength == currentLength
                              ? const Text(
                                  '512/512',
                                  style: TextStyle(color: Colors.red),
                                )
                              : null,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: 'Title',
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color(0xFFEAEAEA), width: 1),
                      borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(5), left: Radius.circular(5)),
                      color: const Color(0xFFF8F8F8),
                    ),
                    width: double.infinity,
                    height: 50,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Transform.rotate(
                        angle: 43.1,
                        child: IconButton(
                          icon: const Icon(
                            Icons.attachment_outlined,
                            color: Colors.grey,
                          ),
                          onPressed: () => newTaskConroller.pickFile(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ValueListenableBuilder<List<PlatformFile>>(
            valueListenable: newTaskConroller.files,
            builder: (context, imgList, value) => FutureBuilder<List<String>>(
              future: newTaskConroller.fetchCommentInfo(),
              initialData: const [],
              builder: ((context, AsyncSnapshot<List<String>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final dateNow = DateTime.now();
                      return Column(
                        children: [
                          ListTile(
                            leading: CachedAvatarWidget(
                              radius: 40,
                              image: snapshot.data![0],
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
                    itemCount: newTaskConroller.files.value.length,
                    shrinkWrap: true,
                  );
                } else {
                  return const CircularProgressIndicator.adaptive();
                }
              }),
            ),
          ),
        ],
      ),
    );
  }
}
