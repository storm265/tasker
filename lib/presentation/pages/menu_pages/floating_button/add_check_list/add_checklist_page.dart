import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/add_check_list/controller/add_check_list_cotnroller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/add_check_list/widgets/add_item_button.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/add_check_list/widgets/check_box_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/add_check_list/widgets/chose_color_text.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/confirm_button.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/red_app_bar.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/title_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/white_box_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/color_pallete_widget.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/services/theme_service/theme_data_controller.dart';

class AddCheckListPage extends StatefulWidget {
  const AddCheckListPage({Key? key}) : super(key: key);

  @override
  State<AddCheckListPage> createState() => _AddCheckListPageState();
}

class _AddCheckListPageState extends State<AddCheckListPage> {
  final _checkListController = AddCheckListController();
  final _titleController = TextEditingController();

  @override
  void dispose() {
    _checkListController.dispose();
    _checkListController.checkBoxItems.dispose();
    _checkListController.colorPalleteController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppbarWrapperWidget(
      appBarColor: Palette.red,
      titleColor: Colors.white,
      title: 'Add Check List',
      showLeadingButton: true,
      shouldUsePopMethod: true,
      child: Stack(
        children: [
          redAppBar,
          WhiteBoxWidget(
            height: 550,
            child: Column(
              children: [
                ListTile(
                  title: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _checkListController.formKey,
                    child: TitleWidget(
                      textController: _titleController,
                      title: 'Title',
                    ),
                  ),
                  subtitle: SizedBox(
                    width: 200,
                    height: 200,
                    child: SingleChildScrollView(
                      child: ValueListenableBuilder<List<String>>(
                        valueListenable: _checkListController.checkBoxItems,
                        builder: (_, value, __) => ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: value.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                CheckBoxWidget(
                                  checkBoxController: _checkListController,
                                  isClicked: _checkListController.isChecked,
                                  index: index,
                                ),
                                (index == value.length - 1)
                                    ? AddItemButton(
                                        onPressed: () =>
                                            _checkListController.addItem(index),
                                      )
                                    : const SizedBox()
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    choseColorText,
                    ColorPalleteWidget(
                      colorController:
                          _checkListController.colorPalleteController,
                    ),
                    const SizedBox(height: 40),
                    ValueListenableBuilder<bool>(
                      valueListenable: _checkListController.isClickedButton,
                      builder: (context, isClicked, child) =>
                          ConfirmButtonWidget(
                        title: 'Done',
                        onPressed: isClicked
                            ? () async => _checkListController.addCheckList(
                                  context: context,
                                  title: _titleController.text,
                                )
                            : null,
                      ),
                    ),
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
