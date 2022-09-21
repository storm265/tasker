import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/grey_container.dart';

class TaskTitleWidget extends StatelessWidget {
  final TextEditingController titleController;
  const TaskTitleWidget({
    Key? key,
    required this.titleController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GreyContainerWidget(
      child: Padding(
        padding: const EdgeInsets.only(left: 40, top: 10),
        child: TextFormField(
          style: const TextStyle(
            fontSize: 18,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w200,
          ),
          validator: (text) {
            if (text == null || text.isEmpty) {
              return 'Please enter title';
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
          maxLength: 256,
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
