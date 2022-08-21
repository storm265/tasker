import 'package:flutter/material.dart';

class CategoryLengthWidget extends StatelessWidget {
  final int taskLength;
  const CategoryLengthWidget({Key? key, required this.taskLength})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Text(
        '$taskLength ${taskLength == 1 ? 'Task' : 'Tasks'}',
        style: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    );
  }
}
