import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/add_check_list/widgets/chose_color_text.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_note/controller/new_note_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/confirm_button.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/red_app_bar.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/title_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/white_box_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/color_pallete_widget.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/services/theme_service/theme_data_controller.dart';

class AddQuickNote extends StatefulWidget {
  const AddQuickNote({Key? key}) : super(key: key);

  @override
  State<AddQuickNote> createState() => _AddQuickNoteState();
}

class _AddQuickNoteState extends State<AddQuickNote> {
  @override
  void dispose() {
    descriptionTextController.dispose();
    _addNoteController.colorPalleteController.dispose();
    _addNoteController.isButtonClicked.dispose();
    _addNoteController.dispose();
    super.dispose();
  }

  final descriptionTextController = TextEditingController();
  final _addNoteController = NewNoteController();
  @override
  Widget build(BuildContext context) {
    return AppbarWrapperWidget(
      appBarColor: Palette.red,

      textColor: Colors.white,
      title: 'Add Note',
      showLeadingButton: true,
      shouldUsePopMethod: true,
      child: Stack(
        children: [
          redAppBar,
          WhiteBoxWidget(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Form(
                    key: _addNoteController.formKey,
                    child: TitleWidget(
                      textController: descriptionTextController,
                      title: 'Description',
                    ),
                  ),
                ),
                const SizedBox(height: 100),
                Column(
                  children: [
                    choseColorText,
                    ColorPalleteWidget(
                      colorController:
                          _addNoteController.colorPalleteController,
                    ),
                    const SizedBox(height: 50),
                    ValueListenableBuilder<bool>(
                      valueListenable: _addNoteController.isButtonClicked,
                      builder: (context, isClicked, _) => ConfirmButtonWidget(
                        title: 'Done',
                        onPressed: isClicked
                            ? () async => _addNoteController.addNote(
                                  context: context,
                                  description: descriptionTextController.text,
                                )
                            : null,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
