// import 'package:flutter/material.dart';
// import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/check_list_page/controller/check_list_controller.dart';

// class InheridtedChecklist extends InheritedWidget {
//   const InheridtedChecklist({
//     Key? key,
//     required this.child,
//     required this.checkListController,
//   }) : super(key: key, child: child);
//   // ignore: overridden_fields, annotate_overrides
//   final Widget child;
//   final AddCheckListController checkListController;

//   static InheridtedChecklist of(BuildContext context) {
//     final InheridtedChecklist? result =
//         context.dependOnInheritedWidgetOfExactType<InheridtedChecklist>();
//     assert(result != null, 'No ProfileInherited found in context');
//     return result!;
//   }

//   @override
//   bool updateShouldNotify(InheridtedChecklist oldWidget) {
//     return checkListController != oldWidget.checkListController;
//   }
// }
