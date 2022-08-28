import 'package:flutter/material.dart';
import 'package:todo2/database/data_source/notes_data_source.dart';
import 'package:todo2/database/repository/notes_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/controller/color_pallete_controller/color_pallete_controller.dart';

import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_note/controller/new_note_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/confirm_button.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/red_app_bar.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/title_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/white_box_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/color_pallete_widget.dart';
import 'package:todo2/presentation/pages/navigation/controllers/inherited_navigator.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/presentation/widgets/common/progress_indicator_widget.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/storage/secure_storage_service.dart';

class AddQuickNote extends StatefulWidget {
  const AddQuickNote({Key? key}) : super(key: key);

  @override
  State<AddQuickNote> createState() => _AddQuickNoteState();
}

class _AddQuickNoteState extends State<AddQuickNote> {
  final _descriptionTextController = TextEditingController();
  final _addNoteController = NewNoteController(
    addNoteRepository: NoteRepositoryImpl(
      noteDataSource: NotesDataSourceImpl(
        network: NetworkSource(),
        secureStorage: SecureStorageService(),
      ),
    ),
    colorPalleteController: ColorPalleteController(),
  );

  @override
  void dispose() {
    _descriptionTextController.dispose();
    _addNoteController.disableValues();
    _addNoteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final navigationController =
        NavigationInherited.of(context).navigationController;
    return AppbarWrapWidget(
      isRedAppBar: true,
      title: 'Add Note',
      showLeadingButton: true,
      isPopFromNavBar: true,
      child: Stack(
        children: [
          const FakeAppBar(),
          WhiteBoxWidget(
            height: 500,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _addNoteController.formKey,
                child: Column(
                  children: [
                    TitleWidget(
                      textInputType: TextInputType.multiline,
                      maxLength: 512,
                      textController: _descriptionTextController,
                      title: 'Description',
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
                                      ? () async =>
                                          _addNoteController.tryValidateNote(
                                            context: context,
                                            description:
                                                _descriptionTextController.text,
                                            navigationController:
                                                navigationController,
                                          )
                                      : null,
                                )
                              : const ProgressIndicatorWidget(
                                  text: 'Adding note...'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
