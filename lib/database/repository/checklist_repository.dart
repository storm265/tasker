import 'package:todo2/database/data_source/checklists_data_source.dart';
import 'package:todo2/database/model/checklist_model.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/storage/secure_storage_service.dart';

abstract class CheckListsRepository<T> {
  Future putCheckList({
    required String title,
    required String color,
  });
  Future fetchCheckList();
  Future fetchCheckListId({required String title});
}

class CheckListsRepositoryImpl extends CheckListsRepository<CheckListModel> {
  final _checkListsDataSource = CheckListsDataSourceImpl(
    network: NetworkSource(),
    secureStorage: SecureStorageService(),
  );
  @override
  Future<void> putCheckList({
    required String title,
    required String color,
  }) async {
    try {
      // await _checkListsDataSource.putCheckList(
      //   color: color,
      //   title: title,
      // );
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<List<CheckListModel>> fetchCheckList() async {
    try {
      // final response = await _checkListsDataSource.fetchCheckList();
      // return (response.data as List<dynamic>)
      //     .map((json) => CheckListModel.fromJson(json))
      //     .toList();
       throw Failure('e.toString()');
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<int> fetchCheckListId({required String title}) async {
    try {
      // int id = await _checkListsDataSource.fetchCheckId(title: title);
      // return id;
      return 0;
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
