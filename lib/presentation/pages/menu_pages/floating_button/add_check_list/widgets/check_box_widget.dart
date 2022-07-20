// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/add_check_list/controller/add_check_list_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/add_text_field.dart';

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
  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: const Color(0xFFF4F4F4),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(width: 10),
          (widget.isClicked)
              ? SizedBox(
                  width: 170,
                  height: 30,
                  child:
                   AddTextFieldWidget(
                    textInputType: TextInputType.multiline,
                    titleController: textController,
                    maxLength: 512,
                    onEdiditionCompleteCallback: () {
                      FocusScope.of(context).unfocus();
                      setState(() {
                        widget.isClicked = false;
                        widget.checkBoxController
                            .editItem(widget.index, textController.text);
                      });
                    },
                  ),
                )
              : GestureDetector(
                  child: Text(widget
                      .checkBoxController.checkBoxItems.value[widget.index]),
                  onTap: () =>
                      setState(() => widget.isClicked = !widget.isClicked),
                ),
          //        (index == 0)
          // ? null
          // : IconButton(
          //     onPressed: () {
          //       checkBoxController.removeItem(index);
          //     },
          //     icon: const Icon(Icons.delete),
          //   ),
          IconButton(
            onPressed: () {
              widget.checkBoxController.removeItem(widget.index);
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
