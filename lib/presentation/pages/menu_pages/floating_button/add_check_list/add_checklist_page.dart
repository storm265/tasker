import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/add_check_list/controller/add_check_list_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/add_check_list/widgets/add_item_button.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/add_check_list/widgets/check_box_widget.dart';
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
    return AppbarWrapWidget(
      isRedAppBar: true,
      title: 'Add Check List',
      showLeadingButton: true,
      child: Stack(
        children: [
          const FakeAppBar(),
          WhiteBoxWidget(
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
                                          onPressed: () => _checkListController
                                              .addItem(index),
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
                              : const ProgressIndicatorWidget(
                                  text: 'Saving...',
                                )),
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
