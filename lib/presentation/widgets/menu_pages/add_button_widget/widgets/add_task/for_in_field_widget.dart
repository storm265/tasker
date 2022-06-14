import 'package:flutter/material.dart';

class EnterUserWidget extends StatelessWidget {
  final TextEditingController titleController;
  final String text;
  const EnterUserWidget({
    Key? key,
    required this.titleController,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 18,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: TextField(
              controller: titleController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                labelStyle: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
          ),
          width: 90,
          height: 45,
          decoration: BoxDecoration(
            color: const Color(0xFFF4F4F4),
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ],
    );
  }
}
