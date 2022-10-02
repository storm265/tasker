import 'package:flutter/material.dart';

class TasksTextWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  const TasksTextWidget({
    Key? key,
    required this.subtitle,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          maxLines: 2,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w200,
            fontStyle: FontStyle.italic,
          ),
        ),
        Text(
          subtitle,
          maxLines: 2,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
