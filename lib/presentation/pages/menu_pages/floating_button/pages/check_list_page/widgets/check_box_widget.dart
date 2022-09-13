import 'package:flutter/material.dart';
import 'package:todo2/database/database_scheme/check_list_items_scheme.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/check_list_page/controller/check_list_controller.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';

// ignore: must_be_immutable
class CheckBoxWidget extends StatefulWidget {
  final CheckListController checkBoxController;
  final int index;
  bool isClicked;
  CheckBoxWidget({
    Key? key,
    required this.isClicked,
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
        (widget.isClicked)
            ? Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: SizedBox(
                  width: 170,
                  height: 35,
                  child: TextField(
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
                    autofocus: true,
                    controller: textController,
                    maxLength: 512,
                    onEditingComplete: () {
                      widget.isClicked = false;
                      widget.checkBoxController.changeCheckboxText(
                        index: widget.index,
                        title: textController.text,
                      );
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ),
              )
            : Expanded(
                child: GestureDetector(
                  child: SelectableText(
                    widget.checkBoxController.checkBoxItems.value[widget.index]
                        [CheckListItemsScheme.content],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF313131),
                    ),
                  ),
                  onTap: () =>
                      setState(() => widget.isClicked = !widget.isClicked),
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
