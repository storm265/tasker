import 'package:flutter/material.dart';

import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/add_check_list/controller/add_check_list_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/add_check_list/widgets/add_item_button.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/add_check_list/widgets/check_box_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/confirm_button.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/red_app_bar.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/title_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/white_box_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/color_pallete_widget.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/presentation/widgets/common/progress_indicator_widget.dart';

class AddCheckListPage extends StatefulWidget {
  const AddCheckListPage({Key? key}) : super(key: key);

  @override
  State<AddCheckListPage> createState() => _AddCheckListPageState();
}

class _AddCheckListPageState extends State<AddCheckListPage> {
  final _checkListController = AddCheckListController();
  final _titleController = TextEditingController();
  final _scrollController = ScrollController();
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
    int index = 0;
    List<String> list = [];
    return AppbarWrapWidget(
      isRedAppBar: true,
      title: 'Add Check List',
      //  showLeadingButton: true,
      child: Stack(
        children: [
          const FakeAppBar(),
          WhiteBoxWidget(
            scrollController: _scrollController,
            height: 600,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: _checkListController.formKey,
                      child: TitleWidget(
                        textInputType: TextInputType.multiline,
                        maxLength: 512,
                        maxLines: 2,
                        textController: _titleController,
                        title: 'Title',
                      ),
                    ),
                    subtitle: SingleChildScrollView(
                      child: ValueListenableBuilder<List<String>>(
                        valueListenable: _checkListController.checkBoxItems,
                        builder: (_, value, __) => ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: value.length,
                          itemBuilder: (_, i) {
                            index = i;
                            list = value;
                            return Column(
                              children: [
                                CheckBoxWidget(
                                  checkBoxController: _checkListController,
                                  isClicked: _checkListController.isChecked,
                                  index: i,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  AddItemButton(onPressed: () {
                    _checkListController.addItem(index);
                    _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent + 20,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInCirc,
                    );
                  }),
                  Column(
                    children: [
                      ColorPalleteWidget(
                        colorController:
                            _checkListController.colorPalleteController,
                      ),
                      const SizedBox(height: 40),
                      ValueListenableBuilder<bool>(
                        valueListenable: _checkListController.isClickedButton,
                        builder: (context, isClicked, _) => isClicked
                            ? ConfirmButtonWidget(
                                title: 'Done',
                                onPressed: isClicked
                                    ? () async {
                                        _checkListController.addCheckList(
                                          context: context,
                                          title: _titleController.text,
                                        );
                                      }
                                    : null,
                              )
                            : const ProgressIndicatorWidget(text: 'Saving...'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
