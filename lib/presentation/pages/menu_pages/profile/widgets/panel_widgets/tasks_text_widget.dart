import 'package:flutter/material.dart';

class TasksTextWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  
  final double left;
  const TasksTextWidget({
    Key? key,
    required this.subtitle,
    required this.title,
    required this.left,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 120,
      left: left,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 60),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
