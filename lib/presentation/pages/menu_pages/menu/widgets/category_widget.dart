import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  final String title;
  const CategoryWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontStyle: FontStyle.italic,
          fontSize: 18,
          fontWeight: FontWeight.w200,
        ),
      ),
    );
  }
}
