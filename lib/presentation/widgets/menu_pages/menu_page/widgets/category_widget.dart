import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  final String title;
  const CategoryWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 125,
      left: 23,
      child: Text(
        title,
        style: const TextStyle(
          fontStyle: FontStyle.italic,
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
