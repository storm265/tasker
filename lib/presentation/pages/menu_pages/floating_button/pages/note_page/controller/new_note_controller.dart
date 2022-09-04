import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:todo2/database/model/notes_model.dart';
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
  final descriptionTextController = TextEditingController();
  final ColorPalleteController colorPalleteController;
  final NoteRepositoryImpl _addNoteRepository;
  final isButtonClicked = ValueNotifier(true);
  final formKey = GlobalKey<FormState>();

  void changeClickedButtonStatus({required bool newValue}) {
    isButtonClicked.value = newValue;
    isButtonClicked.notifyListeners();
  }

  void clearData() {
    descriptionTextController.clear();
    colorPalleteController.changeSelectedIndex(99);
  }

  void pickEditData({required NotesModel notesModel}) {
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

        log('isValid');
          final isSameProject = await isSameNoteCreated(description: descriptionTextController.text);
        if (isSameProject) {
          MessageService.displaySnackbar(
            message: 'This project is already exist',
            context: context,
          );
          descriptionTextController.clear();
        } else {
// TODO is edit
/*
  if (isEdit) {
            await updateProject(
              projectModel: selectedModel.value,
              title: title,
            );

            onSuccessCallback();
          } else {
            await createProject(title: title);
            onSuccessCallback();
          }
*/
 _addNoteRepository
            .createNote(
          color: colors[colorPalleteController.selectedIndex.value],
          description: descriptionTextController.text,
        )
            .then((_) {
          navigationController.moveToPage(Pages.quick);
        });
        }
       

        changeClickedButtonStatus(newValue: true);
      }
    } catch (e) {
      MessageService.displaySnackbar(message: e.toString(), context: context);
    }
  }

  Future<bool> isSameNoteCreated({
    required String description
  }) async {
    try {
      List<NotesModel> projects =
          await _addNoteRepository.fetchUserNotes();
      log('projects list: ${projects.length}');

      for (int i = 0; i < projects.length; i++) {
        if (description.toLowerCase() == projects[i].description.toLowerCase()) {
          return true;
        }
      }

      return false;
    } catch (e) {
      throw Failure(e.toString());
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

  void disposeValues() {
    colorPalleteController.dispose();
    isButtonClicked.dispose();
  }
}
