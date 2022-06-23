import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/add_check_list/widgets/chose_color_text.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/controller/color_pallete_controller/color_pallete_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/confirm_button.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/red_app_bar.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/title_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/white_box_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/color_pallete_widget.dart';
import 'package:todo2/services/theme_service/theme_data_controller.dart';
import 'package:todo2/database/repository/notes_repository.dart';
import 'package:todo2/presentation/pages/navigation_page.dart';
import 'package:todo2/presentation/widgets/common/appbar_widget.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';

class AddQuickNote extends StatefulWidget {
  const AddQuickNote({Key? key}) : super(key: key);

  @override
  State<AddQuickNote> createState() => _AddQuickNoteState();
}

class _AddQuickNoteState extends State<AddQuickNote> {final colorPalleteController = ColorPalleteController();
  @override
  void dispose() {
    descriptionTextController.dispose();
    _colorController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  // TODO: has to be inside of Controller
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
        shouldUsePopMethod: true,
      ),
      body: Stack(
        children: [
          redAppBar,
          WhiteBoxWidget(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Form(
                    key: _formKey,
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
             ColorPalleteWidget(colorController: colorPalleteController,),
                    const SizedBox(height: 50),
                    ConfirmButtonWidget(
                        title: 'Done',
                        onPressed: _isButtonClicked
                            ? () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() => _isButtonClicked = false);
                                  await _addNoteRepository
                                      .putNote(
                                        color: colors[_colorController
                                                .selectedIndex.value]
                                            .value
                                            .toString(),
                                        description:
                                            descriptionTextController.text,
                                      )
                                      .then(
                                          (_) => pageController.jumpToPage(0));

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
