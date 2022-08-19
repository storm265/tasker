import 'package:flutter/material.dart';

class UnfocusWidget extends StatelessWidget {
  final VoidCallback? onClick;
  final Widget child;
  const UnfocusWidget({Key? key, required this.child, this.onClick,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).unfocus();
        onClick!();
      } ,
      child: child,
    );
  }
}
