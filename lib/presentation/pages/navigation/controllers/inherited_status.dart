import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/navigation/controllers/status_bar_controller.dart';

class InheritedStatusBar extends InheritedWidget {
  const InheritedStatusBar({
    Key? key,
    required this.child,
    required this.statusBarController,
  }) : super(key: key, child: child);
  // ignore: overridden_fields, annotate_overrides
  final Widget child;
  final StatusBarController statusBarController;

  static InheritedStatusBar of(BuildContext context) {
    final InheritedStatusBar? result =
        context.dependOnInheritedWidgetOfExactType<InheritedStatusBar>();
    assert(result != null, 'No ProfileInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(InheritedStatusBar oldWidget) {
    return statusBarController != oldWidget.statusBarController;
  }
}
