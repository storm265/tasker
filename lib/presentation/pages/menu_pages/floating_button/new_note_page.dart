import 'package:flutter/material.dart';
import 'package:todo2/controller/add_tasks/color_pallete_controller/color_pallete_controller.dart';
import 'package:todo2/controller/main/theme_data_controller.dart';
import 'package:todo2/database/repository/notes_repository.dart';
import 'package:todo2/presentation/pages/navigation_page.dart';
import 'package:todo2/presentation/widgets/common/appbar_widget.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/presentation/widgets/menu_pages/add_button_widget/common/confirm_button.dart';
import 'package:todo2/presentation/widgets/menu_pages/add_button_widget/common/red_app_bar.dart';
import 'package:todo2/presentation/widgets/menu_pages/add_button_widget/common/title_widget.dart';
import 'package:todo2/presentation/widgets/menu_pages/add_button_widget/white_box_widget.dart';
import 'package:todo2/presentation/widgets/menu_pages/add_button_widget/widgets/add_check_list_widgets/chose_color_text.dart';
import 'package:todo2/presentation/widgets/menu_pages/menu_page/widgets/color_pallete_widget.dart';

class AddQuickNote extends StatefulWidget {
  const AddQuickNote({Key? key}) : super(key: key);

  @override
  State<AddQuickNote> createState() => _AddQuickNoteState();
}

class _AddQuickNoteState extends State<AddQuickNote> {
  @override
  void dispose() {
    descriptionTextController.dispose();
    _colorController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  final _colorController = ColorPalleteController();
  final descriptionTextController = TextEditingController();
  final _addNoteRepository = NoteRepositoryImpl();
  bool _isButtonClicked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(
        appBarColor: Palette.red,
        textColor: Colors.white,
        title: 'Add Note',
        showLeadingButton: true,
      ),
      body: Stack(
        children: [
          redAppBar,
          WhiteBoxWidget(
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
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
                    ColorPalleteWidget(colorController: _colorController),
                    ConfirmButtonWidget(
                        title: 'Done',
                        onPressed: _isButtonClicked
                            ? () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() => _isButtonClicked = false);
                                  await _addNoteRepository.putNote(
                                    color: colors[_colorController
                                            .selectedIndex.value]
                                        .value
                                        .toString(),
                                    description: descriptionTextController.text,
                                  );
                                  pageController.jumpToPage(0);
                                  setState(() => _isButtonClicked = true);
                                }
                              }
                            : null),
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
