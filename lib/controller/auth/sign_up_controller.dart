import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo2/services/supabase/configure.dart';

class SignUpController extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var pickedFile = ValueNotifier(XFile('assets/grey_avatar.jpg'));
  final ImagePicker picker = ImagePicker();

  String avatarUrl = '';
  String avatarKey = '';

  Future<void> signUp(BuildContext context) async {

    final response = await supabase.auth.signUp(
      emailController.text,
      passwordController.text,
    );

    if (response.error != null) {
    } else if (response.data == null && response.user == null) {
      //Please check your email and follow the instructions to verify your email address.

    } else {
      await supabase.from('users').insert({
        'email': emailController.text,
        'password': passwordController.text,
        'created_at': DateTime.now().toIso8601String()
      }).execute();
      // .then((value) => log(value.error!.message));

      Navigator.pushNamedAndRemoveUntil(
        context,
        '/workList',
        (route) => false,
      );
    }
  }

  Future uploadAvatar(BuildContext context) async {
    try {
      pickedFile.value = (await picker.pickImage(
        source: ImageSource.gallery,
      ))!;
      // if (pickedFile == null) {
      //   return;
      // }

      // final size = await pickedFile.value.length();
      // if (size > 1000000) {
      //   throw "The file is too large. Allowed maximum size is 1 MB.";
      // }

      final uploadRes = await supabase.storage
          .from('avatar')
          .upload(pickedFile.value.name, File(pickedFile.value.path))
          .then((value) => log(value.toString()));
      // .uploadBinary(fileName, bytes, fileOptions: fileOptions)

      notifyListeners();
      // showMessage("Avatar updated!");
    } catch (e) {
      //showMessage(e.toString());
    }
  }
}
