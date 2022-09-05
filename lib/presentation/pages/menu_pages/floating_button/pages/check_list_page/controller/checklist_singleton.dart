import 'package:todo2/database/data_source/checklists_data_source.dart';
import 'package:todo2/database/repository/checklist_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/check_list_page/controller/check_list_controller.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/storage/secure_storage_service.dart';

class CheckListSingleton {
  static final CheckListSingleton _instance = CheckListSingleton._internal();

  factory CheckListSingleton() {
    return _instance;
  }

  CheckListSingleton._internal();

  final AddCheckListController _checkListController = AddCheckListController(
    checkListRepository: CheckListRepositoryImpl(
      checkListsDataSource: CheckListsDataSourceImpl(
        network: NetworkSource(),
        secureStorage: SecureStorageSource(),
      ),
    ),
  );

  AddCheckListController get controller => _checkListController;
}