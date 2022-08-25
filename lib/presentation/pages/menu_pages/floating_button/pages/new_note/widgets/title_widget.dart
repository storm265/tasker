import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task/widgets/grey_container.dart';

class TitleWidget extends StatelessWidget {
  final TextEditingController titleController;
  const TitleWidget({Key? key, required this.titleController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GreyContainerWidget(
      child: Padding(
        padding: const EdgeInsets.only(left: 25, top: 10),
        child: TextFormField(
          validator: (text) {
            if (text == null || text.isEmpty) {
              return 'Please enter title text';
            }
            return null;
          },
          controller: titleController,
          buildCounter: (context,
                  {required currentLength, required isFocused, maxLength}) =>
              maxLength == currentLength
                  ? const Text(
                      '32/32',
                      style: TextStyle(color: Colors.red),
                    )
                  : null,
          maxLength: 32,
          decoration: const InputDecoration(
            hintText: 'Title',
            border: InputBorder.none,
            hintStyle: TextStyle(
              fontSize: 18,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
    );
  }
}
