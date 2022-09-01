import 'package:todo2/database/data_source/checklists_data_source.dart';
import 'package:todo2/database/data_source/notes_data_source.dart';
import 'package:todo2/database/model/checklist_model.dart';
import 'package:todo2/database/model/notes_model.dart';
import 'package:todo2/database/repository/checklist_repository.dart';
import 'package:todo2/database/repository/notes_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/check_list_page/controller/check_list_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/controller/notes_controller.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/storage/secure_storage_service.dart';

class QuickController {
  final _checkListController = AddCheckListController(
    checkListRepository: CheckListRepositoryImpl(
      checkListsDataSource: CheckListsDataSourceImpl(
        network: NetworkSource(),
        secureStorage: SecureStorageService(),
      ),
    ),
  );
  final _noteController = NotesController(
    notesRepository: NoteRepositoryImpl(
      noteDataSource: NotesDataSourceImpl(
        network: NetworkSource(),
        secureStorage: SecureStorageService(),
      ),
    ),
  );

  Future<List<dynamic>> fetchList() async {
    await Future.delayed(const Duration(seconds: 2));
    final resposnse = await Future.wait([
      _noteController.fetchUserNotes(),
      _checkListController.fetchAllCheckLists(),
    ]);
    final List<NotesModel> notes = resposnse[0] as List<NotesModel>;
    final List<CheckListModel> checkList = resposnse[1] as List<CheckListModel>;

    List<dynamic> linkedModels = [...notes, ...checkList]
      ..reversed
      ..shuffle();
    return linkedModels;
  }
}
