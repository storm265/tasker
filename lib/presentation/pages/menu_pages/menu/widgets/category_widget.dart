import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class CategoryWidget extends StatelessWidget {
  final String title;
  const CategoryWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: SizedBox(
        width: double.infinity,
        height: 20,
        child: Marquee(
          text: title,
          style: const TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
