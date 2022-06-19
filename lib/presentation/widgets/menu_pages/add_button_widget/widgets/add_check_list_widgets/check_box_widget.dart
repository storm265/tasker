import 'package:flutter/material.dart';
import 'package:todo2/controller/add_tasks/add_check_list_controller/add_check_list_cotnroller.dart';
import 'package:todo2/presentation/widgets/menu_pages/add_button_widget/common/add_text_field.dart';

class CheckBoxWidget extends StatelessWidget {
  final AddCheckListController checkBoxController;
  final textController = TextEditingController();
  final int index;
  bool isClicked;
  CheckBoxWidget({
    Key? key,
    required this.isClicked,
    required this.checkBoxController,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (context, setState) => ListTile(
            title: Row(
              children: [
                Checkbox(value: false, onChanged: (value) {}),
                (isClicked)
                    ? SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SizedBox(
                          width: 170,
                          height: 40,
                          child: AddTextFieldWidget(
                            titleController: textController,
                            maxLength: 30,
                            maxLines: 1,
                            onTap: () => FocusScope.of(context).requestFocus(),
                            onEdiditionCompleteCallback: () {
                              FocusScope.of(context).unfocus();
                              setState(() {
                                isClicked = false;
                                checkBoxController.editItem(
                                    index, textController.text);
                              });
                            },
                          ),
                        ))
                    : GestureDetector(
                        child:
                            Text(checkBoxController.checkBoxItems.value[index]),
                        onTap: () => setState(() => isClicked = !isClicked),
                      ),
              ],
            ),
            trailing: (index == 0)
                ? null
                : IconButton(
                    onPressed: () {
                      checkBoxController.removeItem(index);
                      print(checkBoxController.checkBoxItems.value);
                    },
                    icon: const Icon(Icons.delete))));
  }
}
