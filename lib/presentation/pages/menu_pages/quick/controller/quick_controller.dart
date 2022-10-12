import 'package:flutter/material.dart';
import 'package:todo2/database/model/checklist_model.dart';
import 'package:todo2/database/model/notes_model.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/check_list_page/controller/check_list_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/note_page/controller/new_note_controller.dart';

final quickController = QuickController();

class QuickController extends ChangeNotifier {

  final noteController = NewNoteController();
  final checkListController = CheckListController();

  final linkedModels = ValueNotifier<List<dynamic>>([]);

  List<NotesModel> notes = [];
  List<CheckListModel> checkList = [];

  Future<List<dynamic>> fetchNotes() async {
    notes = await noteController.fetchUserNotes();
    checkList = await checkListController.fetchAllCheckLists();

    linkedModels.value = [...notes, ...checkList]..shuffle();
    linkedModels.value.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    linkedModels.notifyListeners();
    return linkedModels.value;
  }

  Future<void> fetchNotesLocally() async {
    notes = noteController.userNotesList;
    checkList = checkListController.checklist;
    linkedModels.value = [...notes, ...checkList]..shuffle();
    linkedModels.value.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    linkedModels.notifyListeners();
  }
}
