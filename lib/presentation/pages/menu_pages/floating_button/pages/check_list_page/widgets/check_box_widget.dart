// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/check_list_page/controller/check_list_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/add_text_field.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';

class CheckBoxWidget extends StatefulWidget {
  final AddCheckListController checkBoxController;
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
    textController.text =
        widget.checkBoxController.checkBoxItems.value[widget.index][content];
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
                [isCompleted],
            onChanged: (value) => widget.checkBoxController.changeCheckBoxValue(
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
            ? SizedBox(
                width: 170,
                height: 30,
                child: TextField(
                  enabled: true,
                  controller: textController,
                  maxLength: 512,
                  onEditingComplete: () {
                    widget.isClicked = false;
                    widget.checkBoxController.changeCheckBoxText(
                      index: widget.index,
                      title: textController.text,
                    );
                  },
                ),
              )
            : GestureDetector(
                child: Text(
                  widget.checkBoxController.checkBoxItems.value[widget.index]
                      [content],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF313131),
                  ),
                ),
                onTap: () =>
                    setState(() => widget.isClicked = !widget.isClicked),
              ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: IconButton(
            onPressed: () => widget.checkBoxController.removeItem(widget.index),
            icon: const Icon(
              Icons.delete,
              color: darkGrey,
            ),
          ),
        ),
      ],
    );
  }
}
