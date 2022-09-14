import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/add_text_field.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final int maxLength;
  final int? maxLines;
  final VoidCallback? onEdiditionCompleteCallback;
  final TextEditingController textController;
  final TextInputType? textInputType;
  const TitleWidget({
    Key? key,
    required this.textController,
    required this.title,
    this.maxLines,
    this.maxLength = 32,
    this.textInputType,
    this.onEdiditionCompleteCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 17),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w200,
                fontSize: 18,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 14),
          child: AddTextFieldWidget(
            textInputType: textInputType,
            maxLength: maxLength,
            maxLines: maxLines,
            hintText: 'Enter $title:',
            titleController: textController,
            onEdiditionCompleteCallback: onEdiditionCompleteCallback,
          ),
        ),
      ],
    );
  }
}
