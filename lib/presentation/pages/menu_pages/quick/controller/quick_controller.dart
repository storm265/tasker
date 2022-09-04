import 'package:todo2/database/model/checklist_model.dart';
import 'package:todo2/database/model/notes_model.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/check_list_page/controller/check_list_controller.dart';
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
    await Future.delayed(const Duration(seconds: 2));
    final resposnse = await Future.wait([
      _noteController.controller.fetchUserNotes(),
      _checkListController.controller.fetchAllCheckLists(),
    ]);
    final List<NotesModel> notes = resposnse[0] as List<NotesModel>;
    final List<CheckListModel> checkList = resposnse[1] as List<CheckListModel>;

    List<dynamic> linkedModels = [...notes, ...checkList]
      ..reversed
      ..shuffle();
    return linkedModels;
  }
}
