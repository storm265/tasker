import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/controller/auth_controller.dart';

class AvatarWidget extends StatelessWidget {
  final SignUpController signUpController;
  const AvatarWidget({Key? key, required this.signUpController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 95,
      child: InkWell(
        onTap: () => signUpController.pickAvatar(),
        child: ValueListenableBuilder<XFile>(
          valueListenable: signUpController.pickedFile,
          builder: (__, imageFile, _) => Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: (imageFile.path.contains('assets')
                      ? AssetImage(imageFile.path)
                      : FileImage(File(imageFile.path)) as ImageProvider),
                  fit: BoxFit.cover),
              border: Border.all(color: Colors.red, width: 1.5),
              shape: BoxShape.circle,
              color: Colors.black45,
            ),
          ),
        ),
      ),
    );
  }
}
