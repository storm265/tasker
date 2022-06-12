import 'package:flutter/material.dart';

class TasksTextWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final double top;
  final double left;
  const TasksTextWidget({
    Key? key,
    required this.subtitle,
    required this.title,
    required this.left,
    required this.top,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic),
          ),
          Text(
            subtitle,
            style: const TextStyle(
                fontSize: 16, color: Colors.grey, fontStyle: FontStyle.normal),
          ),
        ],
      ),
    );
  }
}
