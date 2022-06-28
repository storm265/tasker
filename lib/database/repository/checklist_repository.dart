
import 'package:todo2/database/data_source/checklists_data_source.dart';
import 'package:todo2/database/model/checklist_model.dart';
import 'package:todo2/services/error_service/error_service.dart';

abstract class CheckListsRepository<T> {
  Future putCheckList({
    required String title,
    required String color,
  });
  Future fetchCheckList();
}

class CheckListsRepositoryImpl extends CheckListsRepository<CheckListModel> {
  final _checkListsDataSource = CheckListsDataSourceImpl();
  @override
  Future<void> putCheckList({
    required String title,
    required String color,
  }) async {
    try {
      await _checkListsDataSource.putCheckList(
        color: color,
        title: title,
      );
    } catch (e) {
      ErrorService.printError(
          'Error in CheckListsRepositoryImpl putCheckList(): $e');
      rethrow;
    }
  }

  @override
  Future<List<CheckListModel>> fetchCheckList() async {
    try {
      final response = await _checkListsDataSource.fetchCheckList();
      
      return (response.data as List<dynamic>)
          .map((json) => CheckListModel.fromJson(json))
          .toList();
    } catch (e) {
      ErrorService.printError('Error in fetchNotes() repository:$e');
      rethrow;
    }
  }
}
