import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:todo2/presentation/controller/image_picker_controller.dart';

class AvatarWidget extends StatelessWidget {
  final ImageController imgController;
  const AvatarWidget({Key? key, required this.imgController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => imgController.pickAvatar(context: context),
      child: ValueListenableBuilder<PlatformFile>(
          valueListenable: imgController.pickedFile,
          builder: (__, imageFile, _) {
            return Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                image: imageFile.path!.isEmpty
                    ? null
                    : DecorationImage(
                        image: FileImage(File(imageFile.path!)),
                        fit: BoxFit.cover,
                      ),
                border: Border.all(color: Colors.red, width: 1.5),
                shape: BoxShape.circle,
                color: const Color(0xffC4C4C4),
              ),
            );
          }),
    );
  }
}
