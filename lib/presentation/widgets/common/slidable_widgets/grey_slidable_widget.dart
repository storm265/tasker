import 'package:flutter/material.dart';

class GreySlidableWidget extends StatelessWidget {
  const GreySlidableWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 2,
      child: ColoredBox(color: Colors.grey.withOpacity(0.25)),
    );
  }
}
