import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo2/controller/main/theme_data_controller.dart';
import 'package:todo2/presentation/widgets/common/appbar_widget.dart';
import 'package:todo2/presentation/widgets/menu_pages/add_button_widget/common/add_text_field.dart';
import 'package:todo2/presentation/widgets/menu_pages/add_button_widget/common/confirm_button.dart';
import 'package:todo2/presentation/widgets/menu_pages/add_button_widget/common/red_app_bar.dart';
import 'package:todo2/presentation/widgets/menu_pages/add_button_widget/common/title_widget.dart';
import 'package:todo2/presentation/widgets/menu_pages/add_button_widget/white_box_widget.dart';
import 'package:todo2/presentation/widgets/menu_pages/add_button_widget/widgets/add_check_list_widgets/add_item_button.dart';
import 'package:todo2/presentation/widgets/menu_pages/add_button_widget/widgets/add_check_list_widgets/chose_color_text.dart';
import 'package:todo2/presentation/widgets/menu_pages/menu_page/widgets/color_pallete_widget.dart';

class AddCheckListPage extends StatefulWidget {
  const AddCheckListPage({Key? key}) : super(key: key);

  @override
  State<AddCheckListPage> createState() => _AddCheckListPageState();
}

class _AddCheckListPageState extends State<AddCheckListPage> {
  final _titleController = TextEditingController();

  bool _isClicked = false;
  int _isSelectedColorIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(
        appBarColor: Palette.red,
        textColor: Colors.white,
        title: 'Add Check List',
        showLeadingButton: true,
      ),
      body: Stack(
        children: [
          redAppBar,
          WhiteBoxWidget(
            height: 550,
            child: Column(
              children: [
                ListTile(
                    title: TitleWidget(
                      textController: _titleController,
                      title: 'Title',
                    ),
                    subtitle: SizedBox(
                      width: 200,
                      height: 200,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: checkBoxItems.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      CheckBoxWidget(
                                        isClicked: _isClicked,
                                        index: index,
                                      ),
                                      (index == checkBoxItems.length - 1)
                                          ? AddItemButton(
                                              onPressed: () => setState(() =>
                                                  checkBoxItems.add(
                                                      'Item index ${checkBoxItems.length + 1}')),
                                            )
                                          : const SizedBox()
                                    ],
                                  );
                                },),
                          ],
                        ),
                      ),
                    )),
                // color pallete
                Column(
                  children: [
                    choseColorText,
                    ColorPalleteWidget(selectedIndex: _isSelectedColorIndex),
                    ConfirmButtonWidget(
                        onPressed: () {
                          //  print(checkBoxItems);
                          //  print(_isSelectedColorIndex);
                        },
                        title: 'Done'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<String> checkBoxItems = ['Item index 1'];

class CheckBoxWidget extends StatelessWidget {
  final textController = TextEditingController();
  final int index;
  bool isClicked;
  CheckBoxWidget({
    Key? key,
    required this.isClicked,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => Row(
        children: [
          Checkbox(value: false, onChanged: (value) {}),
          (isClicked)
              ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: 250,
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
                        });
                        checkBoxItems.replaceRange(
                            index, index + 1, [textController.text]);
                        print(checkBoxItems);
                      },
                    ),
                  ))
              : GestureDetector(
                  child: Text(checkBoxItems[index]),
                  onTap: () => setState(() => isClicked = !isClicked),
                ),
        ],
      ),
    );
  }
}
