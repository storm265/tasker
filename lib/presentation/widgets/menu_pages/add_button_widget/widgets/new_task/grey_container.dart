import 'package:flutter/material.dart';


class GreyContainerWidget extends StatelessWidget {
  final Widget? child;
  const GreyContainerWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      child: child,
      decoration: const BoxDecoration(
        color: Color(0xFFF4F4F4),
      ),
    );
  }
}
