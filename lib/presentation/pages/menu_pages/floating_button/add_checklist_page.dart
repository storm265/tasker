import 'package:flutter/material.dart';
import 'package:todo2/controller/add_tasks/add_check_list_controller/add_check_list_cotnroller.dart';
import 'package:todo2/controller/add_tasks/color_pallete_controller/color_pallete_controller.dart';
import 'package:todo2/controller/main/theme_data_controller.dart';
import 'package:todo2/presentation/pages/navigation_page.dart';
import 'package:todo2/presentation/widgets/common/appbar_widget.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/presentation/widgets/menu_pages/add_button_widget/common/confirm_button.dart';
import 'package:todo2/presentation/widgets/menu_pages/add_button_widget/common/red_app_bar.dart';
import 'package:todo2/presentation/widgets/menu_pages/add_button_widget/common/title_widget.dart';
import 'package:todo2/presentation/widgets/menu_pages/add_button_widget/white_box_widget.dart';
import 'package:todo2/presentation/widgets/menu_pages/add_button_widget/widgets/add_check_list_widgets/add_item_button.dart';
import 'package:todo2/presentation/widgets/menu_pages/add_button_widget/widgets/add_check_list_widgets/check_box_widget.dart';
import 'package:todo2/presentation/widgets/menu_pages/add_button_widget/widgets/add_check_list_widgets/chose_color_text.dart';
import 'package:todo2/presentation/widgets/menu_pages/menu_page/widgets/color_pallete_widget.dart';

class AddCheckListPage extends StatefulWidget {
  const AddCheckListPage({Key? key}) : super(key: key);

  @override
  State<AddCheckListPage> createState() => _AddCheckListPageState();
}

class _AddCheckListPageState extends State<AddCheckListPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  bool _isClickedButton = true;
  bool _isChecked = false;
  final _colorPalleteController = ColorPalleteController();
  final _checkListController = AddCheckListController();

  @override
  void dispose() {
    _colorPalleteController.dispose();
    _titleController.dispose();
    super.dispose();
  }

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
                  title: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _formKey,
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
                                  isClicked: _isChecked,
                                  index: index,
                                ),
                                (index == value.length - 1)
                                    ? AddItemButton(
                                        onPressed: () =>
                                            _checkListController.addItem(index))
                                    : const SizedBox()
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                // color pallete
                Column(
                  children: [
                    choseColorText,
                    ColorPalleteWidget(
                        colorController: _colorPalleteController),
                    ConfirmButtonWidget(
                      onPressed: _isClickedButton
                          ? () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() => _isClickedButton = false);
                                await _checkListController.putChecklist(
                                    color: colors[_colorPalleteController
                                            .selectedIndex.value]
                                        .value
                                        .toString(),
                                    title: _titleController.text);
                                await _checkListController.putChecklistItem();
                                pageController.jumpToPage(0);
                                setState(() => _isClickedButton = true);
                              }
                            }
                          : null,
                      title: 'Done',
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
