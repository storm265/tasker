import 'package:flutter/material.dart';

class ArrowBackWidget extends StatelessWidget {
  final Size size;
  final double left, top;
  const ArrowBackWidget(
      {Key? key, required this.size, required this.left, required this.top})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: size.height * top, //0.015
        left: size.width * left, //0.070
        child: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, size: 30)));
  }
}
