import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class FloatingButtonWidget extends StatelessWidget {
  const FloatingButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 56,
        height: 56,
        child: const Icon(Icons.add, color: Colors.white),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFF96060), Color(0xFFF96060)]),
            shape: BoxShape.circle));
  }
}
