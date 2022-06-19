import 'package:flutter/material.dart';

enum Pages {
  welcome,
  signUp,
  signIn,
  forgotPassword,
  newPassword,
  passwordChanged,
  home,
  workList,
  noConnection,
  addNote,
  addCheckList,
  addTask
}

class NavigationService {
  static Future<void> navigateTo(BuildContext context, Pages page) async {
    switch (page) {
      case Pages.welcome:
        Navigator.pushNamed(context, '/welcome');
        break;
      case Pages.signUp:
        Navigator.pushNamed(context, '/signUp');
        break;
      case Pages.signIn:
        Navigator.pushNamed(context, '/signIn');
        break;
      case Pages.forgotPassword:
        Navigator.pushNamed(context, '/forgotPassword');
        break;
      case Pages.newPassword:
        Navigator.pushNamedAndRemoveUntil(context, '/newPassword',((_) => false));
        break;
      case Pages.passwordChanged:
        Navigator.pushNamedAndRemoveUntil(context, '/passwordChanged',((_) => false));
        break;
      case Pages.workList:
        Navigator.pushNamed(context, '/workList');
        break;
      case Pages.home:
        Navigator.pushNamed(context, '/home');
        break;
      case Pages.noConnection:
        Navigator.pushNamed(context, '/noConnection');
        break;

      case Pages.addCheckList:
        Navigator.pushNamed(context, '/addCheckList');
        break;
      case Pages.addNote:
        Navigator.pushNamed(context, '/addNote');
        break;
      case Pages.addTask:
        Navigator.pushNamed(context, '/addTask');
        break;
    }
  }
}
