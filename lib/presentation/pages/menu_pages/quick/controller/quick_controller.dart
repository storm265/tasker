import 'package:flutter/material.dart';
import 'package:todo2/database/model/checklist_model.dart';
import 'package:todo2/database/model/notes_model.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/check_list_page/controller/check_list_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/note_page/controller/new_note_controller.dart';

final quickController = QuickController();

class QuickController extends ChangeNotifier {
  // static final QuickController _instance = QuickController._internal();

  // factory QuickController() {
  //   log('QuickController created');
  //   return _instance;
  // }

  // QuickController._internal();

  final _noteController = NewNoteController();
  final _checkListController = CheckListController();

  final linkedModels = ValueNotifier<List<dynamic>>([]);

  Future<void> fetchList() async {
    final responce = await Future.wait([
      _noteController.fetchUserNotes(),
      _checkListController.fetchAllCheckLists(),
    ]);
    final List<NotesModel> notes = responce[0] as List<NotesModel>;
    final List<CheckListModel> checkList = responce[1] as List<CheckListModel>;

    linkedModels.value = [...notes, ...checkList]..shuffle();
    linkedModels.value.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    linkedModels.notifyListeners();
  }
}
