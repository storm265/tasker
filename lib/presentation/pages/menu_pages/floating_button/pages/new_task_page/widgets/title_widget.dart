import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/auth/widgets/unfocus_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/common/grey_container.dart';

class TaskTitleWidget extends StatelessWidget {
  final TextEditingController titleController;
  const TaskTitleWidget({
    Key? key,
    required this.titleController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UnfocusWidget(
      child: GreyContainerWidget(
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
                return LocaleKeys.please_enter_title.tr();
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
            decoration: InputDecoration(
              hintText: LocaleKeys.title.tr(),
              border: InputBorder.none,
              hintStyle: const TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
