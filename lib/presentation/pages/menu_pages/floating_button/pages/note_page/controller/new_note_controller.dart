import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/database/data_source/notes_data_source.dart';
import 'package:todo2/database/model/notes_model.dart';
import 'package:todo2/database/repository/notes_repository.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/controller/color_pallete_controller/color_pallete_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/controller/quick_controller.dart';
import 'package:todo2/presentation/pages/navigation/controllers/navigation_controller.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/services/message_service/message_service.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/storage/secure_storage_service.dart';

class NewNoteController extends ChangeNotifier {
  static final NewNoteController _instance = NewNoteController._internal();

  factory NewNoteController() {
    return _instance;
  }

  NewNoteController._internal();

  final _addNoteRepository = NoteRepositoryImpl(
    noteDataSource: NotesDataSourceImpl(
      network: NetworkSource(),
      secureStorage: SecureStorageSource(),
    ),
  );

  final descriptionTextController = TextEditingController();

  final colorPalleteController = ColorPalleteController();

  final isButtonClicked = ValueNotifier(true);

  final isEdit = ValueNotifier(false);

  final _pickedModel = ValueNotifier(
    NotesModel(
      id: '',
      isCompleted: false,
      color: Colors.red,
      description: '',
      ownerId: '',
      createdAt: DateTime(2022),
    ),
  );

  List<NotesModel> userNotesList = [];

  void changeEditValueStatus(bool status) {
    isEdit.value = status;
    isEdit.notifyListeners();
  }

  void changeClickedButtonValueStatus({required bool newValue}) {
    isButtonClicked.value = newValue;
    isButtonClicked.notifyListeners();
  }

  void clearData() {
    descriptionTextController.clear();
    colorPalleteController.changeSelectedIndex(99);
    changeEditValueStatus(false);
  }

  void pickEditData({required NotesModel notesModel}) {
    changeEditValueStatus(true);
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
    required NavigationController navigationController,
    required GlobalKey<FormState> formKey,
    required BuildContext context,
  }) async {
    try {
      if (formKey.currentState!.validate() &&
          !colorPalleteController.isNotPickerColor) {
        FocusScope.of(context).unfocus();
        changeClickedButtonValueStatus(newValue: false);
        log('isEdit $isEdit');
        if (isEdit.value) {
          await updateNote();
          MessageService.displaySnackbar(
            context: context,
            message: LocaleKeys.updated.tr(),
          );
        } else {
          await createNote();
          MessageService.displaySnackbar(
            context: context,
            message: LocaleKeys.created.tr(),
          );
        }
        clearData();
        quickController.fetchNotesLocally();

        await navigationController.moveToPage(Pages.quick);
      }
    } finally {
      changeClickedButtonValueStatus(newValue: true);
    }
  }

  Future<void> createNote() async {
    final model = await _addNoteRepository.createNote(
      color: colors[colorPalleteController.selectedIndex.value],
      description: descriptionTextController.text,
    );
    userNotesList.add(model);
  }

  Future<List<NotesModel>> fetchUserNotes() async {
    final notes = await _addNoteRepository.fetchUserNotes();
    userNotesList = notes;
    return notes;
  }

  Future<void> deleteNote({
    required NotesModel notesModel,
    required BuildContext context,
  }) async {
    await _addNoteRepository.deleteNote(projectId: notesModel.id);
    userNotesList.removeWhere((element) => element.id == notesModel.id);
    quickController.fetchNotesLocally();
    MessageService.displaySnackbar(
      context: context,
      message: LocaleKeys.deleted.tr(),
    );
  }

  Future<void> updateNote() async {
    final updatedModel = await _addNoteRepository.updateNote(
      color: colors[colorPalleteController.selectedIndex.value],
      noteModel: _pickedModel.value,
      description: descriptionTextController.text,
    );
    for (var i = 0; i < userNotesList.length; i++) {
      if (userNotesList[i].id == updatedModel.id) {
        userNotesList[i] = updatedModel;
        break;
      }
    }
  }

  Future<void> updateAsDone({
    required NotesModel pickedModel,
    required BuildContext context,
  }) async {
    NotesModel model = pickedModel.copyWith(isCompleted: true);
    final newModel = await _addNoteRepository.updateNote(
      color: model.color,
      noteModel: model,
      description: model.description,
    );
    for (var i = 0; i < userNotesList.length; i++) {
      if (userNotesList[i].id == newModel.id) {
        userNotesList[i] = newModel;
        break;
      }
    }
    quickController.fetchNotesLocally();
  }
}
