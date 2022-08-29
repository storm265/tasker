import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:todo2/database/data_source/checklists_data_source.dart';
import 'package:todo2/database/repository/checklist_items_repository.dart';
import 'package:todo2/database/repository/checklist_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/controller/color_pallete_controller/color_pallete_controller.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/message_service/message_service.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/storage/secure_storage_service.dart';

class AddCheckListController extends ChangeNotifier {
  final _checkListItemsRepository = ChecklistItemsRepositoryImpl();
  final _checkListRepository = CheckListsRepositoryImpl(
      checkListsDataSource: CheckListsDataSourceImpl(
    network: NetworkSource(),
    secureStorage: SecureStorageService(),
  ));
  final checkBoxItems = ValueNotifier<List<Map<String, dynamic>>>([  {
            "content": "asdsad asd",
            "is_completed": false
        },
        {
            "content": "qweqweqwe",
            "is_completed": false
        }]);

  final colorPalleteController = ColorPalleteController();
  final formKey = GlobalKey<FormState>();

  final isClickedButton = ValueNotifier(true);
  final isChecked = false;

  Future<void> tryValidateCheckList({
    required BuildContext context,
    required String title,
    required Color color,
    List<Map<String, dynamic>>? items,
  }) async {
    try {
      if (formKey.currentState!.validate()) {
        isClickedButton.value = false;
        isClickedButton.notifyListeners();
        await createCheckList(
          title: title,
          color: color,
        );
        // await putChecklistItem()
        //     .then((_) => NavigationService.navigateTo(context, Pages.tasks));

        isClickedButton.value = true;
        isClickedButton.notifyListeners();
      }
    } catch (e) {
      MessageService.displaySnackbar(context: context, message: e.toString());
    }
  }

  Future<void> createCheckList({
    required String title,
    required Color color,
    List<Map<String, dynamic>>? items,
  }) async {
    try {
      await _checkListRepository.createCheckList(title: title, color: color);
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  void addItem(int index) {
    checkBoxItems.value.add('Item index ${index + 1 + 1}');
    checkBoxItems.notifyListeners();
  }

  void editItem(int index, String title) {
    checkBoxItems.value.replaceRange(index, index + 1, [title]);
    checkBoxItems.notifyListeners();
  }

  void removeItem(int index) {
    if (checkBoxItems.value.length != 1) {
      checkBoxItems.value.removeAt(index);
      checkBoxItems.notifyListeners();
    }
  }
}
