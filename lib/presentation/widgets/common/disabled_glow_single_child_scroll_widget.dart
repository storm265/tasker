import 'package:flutter/material.dart';


class DisabledGlowScrollView extends StatelessWidget {
  final Widget child;
  const DisabledGlowScrollView({Key? key,required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child:child);
  }
}