import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/navigation/controllers/navigation_controller.dart';

class InheritedNavigator extends InheritedWidget {
  const InheritedNavigator(
      {Key? key, required this.child, required this.navigationController})
      : super(key: key, child: child);



  // ignore: overridden_fields, annotate_overrides
  final Widget child;
  final NavigationController navigationController;

  static InheritedNavigator? of(BuildContext context) {
    
    final InheritedNavigator? result =
        context.dependOnInheritedWidgetOfExactType<InheritedNavigator>();
    assert(result != null, 'No ProfileInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(InheritedNavigator oldWidget) {
    return navigationController != oldWidget.navigationController;
  }
}