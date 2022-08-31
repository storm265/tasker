import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:todo2/database/data_source/checklists_data_source.dart';
import 'package:todo2/database/model/checklist_model.dart';
import 'package:todo2/database/repository/checklist_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/controller/color_pallete_controller/color_pallete_controller.dart';
import 'package:todo2/presentation/pages/navigation/controllers/navigation_controller.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/message_service/message_service.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/storage/secure_storage_service.dart';

const isCompleted = 'is_completed';
const content = 'content';

class AddCheckListController extends ChangeNotifier {
  final CheckListRepositoryImpl _checkListRepository;
  AddCheckListController({required CheckListRepositoryImpl checkListRepository})
      : _checkListRepository = checkListRepository;

  final checkBoxItems = ValueNotifier<List<Map<String, dynamic>>>([]);

  final colorPalleteController = ColorPalleteController();
  final formKey = GlobalKey<FormState>();

  final isClickedButton = ValueNotifier(true);
  final isChecked = false;

  void changeButtonStatus(bool status) {
    isClickedButton.value = status;
    isClickedButton.notifyListeners();
  }

  Future<void> tryValidateCheckList({
    required BuildContext context,
    required String title,
    required Color color,
    List<Map<String, dynamic>>? items,
    required NavigationController navigationController,
  }) async {
    try {
      if (formKey.currentState!.validate() &&
          !colorPalleteController.isNotPickerColor) {
        changeButtonStatus(false);
        await createCheckList(
          title: title,
          color: color,
          items: checkBoxItems.value,
        );
        // .then((value) =>navigationController.moveToPage(Pages.quick) );

        changeButtonStatus(true);
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
      await _checkListRepository.createCheckList(
        title: title,
        color: color,
        items: items,
      );
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<List<CheckListModel>> fetchAllCheckLists() async {
    try {
      return _checkListRepository.fetchAllCheckLists();
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  void changeCheckBoxValue({required int index, required bool? value}) {
    checkBoxItems.value[index][isCompleted] = value;
    checkBoxItems.notifyListeners();
  }

  void addItem(int index) {
    checkBoxItems.value.add({
      content: checkBoxItems.value.isEmpty
          ? 'List item 1'
          : 'List item ${index + 1 + 1}',
      isCompleted: false,
    });
    checkBoxItems.notifyListeners();
  }

  void changeCheckBoxText({
    required int index,
    required String title,
  }) {
    if (title.isEmpty) {
      removeItem(index);
    } else {
      checkBoxItems.value[index][content] = title;
    }

    checkBoxItems.notifyListeners();
  }

  void removeItem(int index) {
    checkBoxItems.value.removeAt(index);
    checkBoxItems.notifyListeners();
  }
}
