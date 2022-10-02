import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/navigation/controllers/navigation_controller.dart';


class NavigationInherited extends InheritedWidget {
  const NavigationInherited({
    Key? key,
    required this.child,
    required this.navigationController,
  }) : super(key: key, child: child);
  // ignore: overridden_fields, annotate_overrides
  final Widget child;
  final NavigationController navigationController;

  static NavigationInherited of(BuildContext context) {
    final NavigationInherited? result =
        context.dependOnInheritedWidgetOfExactType<NavigationInherited>();
    assert(result != null, 'No ProfileInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(NavigationInherited oldWidget) {
    return navigationController != oldWidget.navigationController;
  }
}
