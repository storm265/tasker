import 'package:flutter/material.dart';
import 'package:todo2/database/repository/notes_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/controller/color_pallete_controller/color_pallete_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_note/controller/new_note_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/confirm_button.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/red_app_bar.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/title_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/white_box_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/color_pallete_widget.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/presentation/widgets/common/progress_indicator_widget.dart';

class AddQuickNote extends StatefulWidget {
  const AddQuickNote({Key? key}) : super(key: key);

  @override
  State<AddQuickNote> createState() => _AddQuickNoteState();
}

class _AddQuickNoteState extends State<AddQuickNote> {
  final descriptionTextController = TextEditingController();
  final _addNoteController = NewNoteController(
    addNoteRepository: NoteRepositoryImpl(),
    colorPalleteController: ColorPalleteController(),
  );

  @override
  void dispose() {
    descriptionTextController.dispose();
    _addNoteController.colorPalleteController.dispose();
    // TODO careful!
    _addNoteController.isButtonClicked.dispose();
    _addNoteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppbarWrapperWidget(
      isRedAppBar: true,
      title: 'Add Note',
      showLeadingButton: true,
      shouldUsePopMethod: true,
      child: Stack(
        children: [
          const FakeAppBar(),
          WhiteBoxWidget(
            height: 500,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Column(
                children: [
                  Form(
                    key: _addNoteController.formKey,
                    child: TitleWidget(
                      textInputType: TextInputType.multiline,
                      maxLength: 512,
                      textController: descriptionTextController,
                      title: 'Description',
                    ),
                  ),
                  Column(
                    children: [
                      ColorPalleteWidget(
                          colorController:
                              _addNoteController.colorPalleteController),
                      const SizedBox(height: 50),
                      ValueListenableBuilder<bool>(
                        valueListenable: _addNoteController.isButtonClicked,
                        builder: (context, isClicked, _) => isClicked
                            ? ConfirmButtonWidget(
                                title: 'Done',
                                onPressed: isClicked
                                    ? () async => _addNoteController.addNote(
                                          context: context,
                                          description:
                                              descriptionTextController.text,
                                        )
                                    : null,
                              )
                            : const ProgressIndicatorWidget(
                                text: 'Adding note...',
                              ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
