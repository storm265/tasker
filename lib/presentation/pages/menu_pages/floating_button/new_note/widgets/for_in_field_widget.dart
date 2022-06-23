// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class EnterUserWidget extends StatefulWidget {
  TextEditingController titleController;
  bool showPickUserWidget;
  final String text;
  EnterUserWidget({
    Key? key,
    required this.titleController,
    required this.text,
    required this.showPickUserWidget,
  }) : super(key: key);

  @override
  State<EnterUserWidget> createState() => _EnterUserWidgetState();
}

class _EnterUserWidgetState extends State<EnterUserWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 5),
          child: Text(
            'For',
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 18,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        Container(
          width: 90,
          height: 45,
          decoration: BoxDecoration(
            color: const Color(0xFFF4F4F4),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: TextField(
              onTap: () {
                widget.titleController.clear();
                setState(() {
                  widget.showPickUserWidget = true;
                });
              },
              controller: widget.titleController,
              onEditingComplete: () {
                setState(() {
                  widget.showPickUserWidget = false;
                });
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                labelStyle: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
