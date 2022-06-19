import 'package:flutter/material.dart';
import 'package:todo2/presentation/widgets/common/disabled_glow_single_child_scroll_widget.dart';

class WhiteBoxWidget extends StatelessWidget {
  final Widget child;
  final double height;
  const WhiteBoxWidget({
    Key? key,
    required this.child,
    this.height = 468,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DisabledGlowWidget(
        child: SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(left: 25, top: 10),
        width: 350,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFDDDDDD),
              blurRadius: 9,
              offset: Offset(3, 3),
            )
          ],
          borderRadius: BorderRadius.circular(5),
        ),
        child: child,
      ),
    ));
  }
}
