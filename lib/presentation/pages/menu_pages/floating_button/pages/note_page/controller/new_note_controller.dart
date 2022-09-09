import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo2/database/model/notes_model.dart';
import 'package:todo2/database/repository/notes_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/controller/color_pallete_controller/color_pallete_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/quick_page.dart';
import 'package:todo2/presentation/pages/navigation/controllers/navigation_controller.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/message_service/message_service.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';

class NewNoteController extends ChangeNotifier {
  NewNoteController({
    required this.colorPalleteController,
    required NoteRepositoryImpl addNoteRepository,
  }) : _addNoteRepository = addNoteRepository;
  final descriptionTextController = TextEditingController();
  final ColorPalleteController colorPalleteController;
  final NoteRepositoryImpl _addNoteRepository;
  final isButtonClicked = ValueNotifier(true);
  final formKey = GlobalKey<FormState>();
  final isEdit = ValueNotifier(false);

  void changeEditStatus(bool status) {
    isEdit.value = status;
    isEdit.notifyListeners();
  }

  bool isCreateMode() {
    if (descriptionTextController.text.isEmpty) {
      debugPrint('text len: ${descriptionTextController.text.length}');
      log('its create mode;');
      changeEditStatus(false);
      return true;
    } else {
      log('its edit mode;');
      changeEditStatus(true);
      return false;
    }
  }

  void changeClickedButtonStatus({required bool newValue}) {
    isButtonClicked.value = newValue;
    isButtonClicked.notifyListeners();
  }

  void clearData() {
    descriptionTextController.clear();
    colorPalleteController.changeSelectedIndex(99);
  }

  final _pickedModel = ValueNotifier(NotesModel(
    id: '',
    isCompleted: false,
    color: Colors.red,
    description: '',
    ownerId: '',
    createdAt: '',
  ));

  void pickEditData({required NotesModel notesModel}) {
    _pickedModel.value = notesModel;
    _pickedModel.notifyListeners();
    for (int i = 0; i < colors.length; i++) {
      if (colors[i] == notesModel.color) {
        colorPalleteController.changeSelectedIndex(i);
        break;
      }
    }
    descriptionTextController.text = notesModel.description;
  }

  Future<void> tryValidateNote({
    required BuildContext context,
    required NavigationController navigationController,
  }) async {
    try {
      if (formKey.currentState!.validate() &&
          !colorPalleteController.isNotPickerColor) {
        changeClickedButtonStatus(newValue: false);

        if (isCreateMode()) {
          log('is edit mode');
          await updateNote().then((_) {
            QuickPage.of(context).updateState();
            navigationController.moveToPage(Pages.quick);
          });
        } else {
          await _addNoteRepository
              .createNote(
            color: colors[colorPalleteController.selectedIndex.value],
            description: descriptionTextController.text,
          )
              .then((_) {
            QuickPage.of(context).updateState();
            navigationController.moveToPage(Pages.quick);
          });
        }

        changeClickedButtonStatus(newValue: true);
      }
    } catch (e) {
      log('tryValidateNote $e');
      MessageService.displaySnackbar(message: e.toString(), context: context);
    }
  }

  Future<List<NotesModel>> fetchUserNotes() async {
    try {
      return await _addNoteRepository.fetchUserNotes();
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<void> deleteNote({
    required NotesModel notesModel,
    required BuildContext context,
  }) async {
    try {
      await _addNoteRepository
          .deleteNote(projectId: notesModel.id)
          .then((_) => QuickPage.of(context).updateState());
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<void> updateNote() async {
    try {
      await _addNoteRepository.updateNote(
        color: colors[colorPalleteController.selectedIndex.value],
        noteModel: _pickedModel.value,
        description: descriptionTextController.text,
      );
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<void> updateAsDone({
    required NotesModel pickedModel,
    required BuildContext context,
  }) async {
    try {
      NotesModel model = pickedModel.copyWith(isCompleted: true);
      await _addNoteRepository
          .updateNote(
            color: model.color,
            noteModel: model,
            description: model.description,
          )
          .then((_) => QuickPage.of(context).updateState());
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  void disposeValues() {
    colorPalleteController.dispose();
    isButtonClicked.dispose();
  }
}
