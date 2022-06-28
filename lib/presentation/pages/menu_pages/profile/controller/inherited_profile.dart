import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/controller/profile_controller.dart';

class ProfileInherited extends InheritedWidget {
  const ProfileInherited({
    Key? key,
    required this.child,
    required this.profileController,
  }) : super(key: key, child: child);

  final Widget child;
  final ProfileController profileController;

  static ProfileInherited of(BuildContext context) {
    final ProfileInherited? result =
        context.dependOnInheritedWidgetOfExactType<ProfileInherited>();
    assert(result != null, 'No ProfileInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ProfileInherited oldWidget) {
    return profileController != oldWidget.profileController;
  }
}