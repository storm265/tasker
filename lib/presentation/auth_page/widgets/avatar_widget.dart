import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo2/controller/auth/sign_up_controller.dart';

class AvatarWidget extends StatelessWidget {
  final Size size;
  final _signUpController = SignUpController();
  AvatarWidget({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: size.height * 0.29,
        child: InkWell(
            onTap: () => _signUpController.uploadAvatar(context),
            child: ValueListenableBuilder<XFile>(
                valueListenable: _signUpController.pickedFile,
                builder: (__, imageFile, _) => Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(File(imageFile.path))
                                as ImageProvider,
                            fit: BoxFit.cover),
                        border: Border.all(color: Colors.red, width: 1.5),
                        shape: BoxShape.circle,
                        color: Colors.black45)))));
  }
}
