import 'package:todo2/database/model/checklist_model.dart';
import 'package:todo2/database/model/notes_model.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/check_list_page/controller/checklist_singleton.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/note_page/controller/note_singleton.dart';

class QuickController {
  final NoteSingleton _noteController;
  final CheckListSingleton _checkListController;

  QuickController({
    required NoteSingleton noteController,
    required CheckListSingleton checkListController,
  })  : _noteController = noteController,
        _checkListController = checkListController;

  Future<List<dynamic>> fetchList() async {
    final responce = await Future.wait([
      _noteController.controller.fetchUserNotes(),
      _checkListController.controller.fetchAllCheckLists(),
    ]);
    final List<NotesModel> notes = responce[0] as List<NotesModel>;
    final List<CheckListModel> checkList = responce[1] as List<CheckListModel>;

    List<dynamic> linkedModels = [...notes, ...checkList]
      ..reversed
      ..shuffle();
    return linkedModels;
  }

 
}
