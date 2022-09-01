import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:todo2/database/model/notes_model.dart';
import 'package:todo2/database/model/project_models/projects_model.dart';
import 'package:todo2/database/repository/notes_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/controller/color_pallete_controller/color_pallete_controller.dart';
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

  final ColorPalleteController colorPalleteController;
  final NoteRepositoryImpl _addNoteRepository;
  final isButtonClicked = ValueNotifier(true);
  final formKey = GlobalKey<FormState>();

  void changeClickedButtonStatus({required bool newValue}) {
    isButtonClicked.value = newValue;
    isButtonClicked.notifyListeners();
  }

  Future<void> tryValidateNote({
    required BuildContext context,
    required String description,
    required NavigationController navigationController,
  }) async {
    try {
      if (formKey.currentState!.validate() &&
          !colorPalleteController.isNotPickerColor) {
        changeClickedButtonStatus(newValue: false);
// TODO is edit
        log('isValid');
        _addNoteRepository
            .createNote(
          color: colors[colorPalleteController.selectedIndex.value],
          description: description,
        )
            .then((_) {
          navigationController.moveToPage(Pages.quick);
        });

        changeClickedButtonStatus(newValue: true);
      }
    } catch (e) {
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
    required NotesModel projectModel,
  }) async {
    try {
      _addNoteRepository.deleteNote(projectId: projectModel.id);
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<void> updateNote({
    required NotesModel projectModel,
  }) async {
    try {
      _addNoteRepository.updateNote(noteModel: projectModel);
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<bool> isDublicated({
    required String projectId,
  }) async {
    try {
      final notesList = await _addNoteRepository.fetchUserNotes();
      for (int i = 0; i < notesList.length; i++) {
        if (notesList[i].id == projectId) {
          return true;
        }
      }
      return false;
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  void disableValues() {
    colorPalleteController.dispose();
    isButtonClicked.dispose();
  }
}
