import 'package:flutter/material.dart';

class CategoryLengthWidget extends StatelessWidget {
  final int taskLength;
  const CategoryLengthWidget({Key? key, required this.taskLength})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '$taskLength tasks',
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 16,
      ),
    );
  }
}
