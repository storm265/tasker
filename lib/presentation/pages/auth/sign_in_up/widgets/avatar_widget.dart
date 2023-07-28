import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:todo2/presentation/providers/file_provider.dart';
import 'package:todo2/presentation/widgets/common/add_photo_widget.dart';
import 'package:todo2/utils/theme_util.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    Key? key,
    required this.imgController,
  }) : super(key: key);

  final FileProvider imgController;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
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
              border: Border.all(color: Palette.red, width: 1.5),
              shape: BoxShape.circle,
              color: const Color(0xffC4C4C4),
            ),
            child: imageFile.path!.isEmpty ? addPhotoWidget : null,
          );
        },
      ),
    );
  }
}
