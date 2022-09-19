import 'package:flutter/material.dart';
import 'package:todo2/database/database_scheme/check_list_items_scheme.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/check_list_page/controller/check_list_controller.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';

// ignore: must_be_immutable
class CheckBoxWidget extends StatefulWidget {
  final CheckListController checkBoxController;
  final int index;

  const CheckBoxWidget({
    Key? key,
    required this.checkBoxController,
    required this.index,
  }) : super(key: key);

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  late final textController = TextEditingController();
  @override
  void initState() {
    textController.text = widget.checkBoxController.checkBoxItems
        .value[widget.index][CheckListItemsScheme.content];

    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.scale(
          scale: 1.1,
          child: Checkbox(
            value: widget.checkBoxController.checkBoxItems.value[widget.index]
                [CheckListItemsScheme.isCompleted],
            onChanged: (value) => widget.checkBoxController.changeCheckboxValue(
              index: widget.index,
              value: value,
            ),
            side: const BorderSide(
              color: Colors.grey,
              width: 1,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: SizedBox(
            width: 170,
            height: 40,
            child: TextField(
              onTap: () => !widget.checkBoxController.isEditStatus.value
                  ? textController.clear()
                  : null,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                fontStyle: FontStyle.normal,
                color: Colors.black,
              ),
              decoration: const InputDecoration(border: InputBorder.none),
              buildCounter: (
                context, {
                required currentLength,
                required isFocused,
                maxLength,
              }) =>
                  maxLength == currentLength
                      ? Text(
                          '$maxLength/$maxLength',
                          style: const TextStyle(color: Colors.red),
                        )
                      : null,
              controller: textController,
              maxLength: 512,
              onChanged: ((value) =>
                  widget.checkBoxController.changeCheckboxText(
                    index: widget.index,
                    title: textController.text.trim(),
                  )),
              onEditingComplete: () => FocusScope.of(context).unfocus(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: GestureDetector(
            onTap: () =>
                widget.checkBoxController.removeCheckboxItem(widget.index),
            child: const Icon(
              Icons.delete,
              color: darkGrey,
            ),
          ),
        ),
      ],
    );
  }
}
