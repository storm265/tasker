import 'package:flutter/material.dart';

import 'package:todo2/presentation/widgets/menu_pages/add_button_widget/common/add_text_field.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final TextEditingController textController;

  const TitleWidget({
    Key? key,
    required this.textController,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 18,
                fontStyle: FontStyle.italic,
                color: Colors.black,
              ),
            ),
          ),
          AddTextFieldWidget(
            maxLines: 10,
            hintText: 'Enter $title:',
            titleController: textController,
          ),
        ],
      ),
    );
  }
}
