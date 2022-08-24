import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_note/widgets/atachment_message_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_task/controller/controller_inherited.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/widgets/panel_widgets/cached_avatar_widget.dart';
import 'package:todo2/presentation/widgets/common/progress_indicator_widget.dart';
import 'package:todo2/utils/assets_path.dart';

class DescriptionFieldWidget extends StatelessWidget {
  final TextEditingController descriptionController;
  final String? hintText;
  final bool showImageIcon;
  final int maxLength;
  const DescriptionFieldWidget({
    Key? key,
    required this.descriptionController,
    this.hintText,
    this.maxLength = 512,
    this.showImageIcon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newTaskController =
        InheritedNewTaskController.of(context).addTaskController;
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
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      top: 20,
                    ),
                    child: TextFormField(
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Please enter description text';
                        }
                        return null;
                      },
                      controller: descriptionController,
                      onEditingComplete: () => FocusScope.of(context).unfocus(),
                      maxLength: maxLength,
                      buildCounter: (
                        context, {
                        required currentLength,
                        required isFocused,
                        maxLength,
                      }) =>
                          maxLength == currentLength
                              ? Text(
                                  '$maxLength/$maxLength',
                                  style: const TextStyle(color: Colors.red),
                                )
                              : null,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: hintText,
                        border: InputBorder.none,
                        hintStyle: const TextStyle(
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
                    height: 40,
                    child: Row(
                      children: [
                        showImageIcon
                            ? Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: GestureDetector(
                                  child: SvgPicture.asset(AssetsPath.imageIconIconPath),
                                ),
                              )
                            : const SizedBox(),
                        Transform.rotate(
                          angle: 43.1,
                          child: IconButton(
                            icon: const Icon(
                              Icons.attachment_outlined,
                              color: Colors.grey,
                            ),
                            onPressed: () =>
                                newTaskController.pickFile(context: context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const AttachementWidget(),
          ValueListenableBuilder<List<PlatformFile>>(
            valueListenable: newTaskController.files,
            builder: (context, imgList, value) => FutureBuilder<List<String>>(
              future: newTaskController.fetchCommentInfo(),
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
                          // ListTile(
                          //   leading: CachedAvatarWidget(
                          //     radius: 40,
                          //     image: snapshot.data![index],
                          //   ),
                          //   title: Text(snapshot.data![1]),
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
                    itemCount: newTaskController.files.value.length,
                    shrinkWrap: true,
                  );
                } else {
                  return const ProgressIndicatorWidget();
                }
              }),
            ),
          ),
        ],
      ),
    );
  }
}
