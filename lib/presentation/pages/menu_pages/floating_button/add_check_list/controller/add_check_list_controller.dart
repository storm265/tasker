import 'package:flutter/material.dart';
import 'package:todo2/database/repository/checklist_items_repository.dart';
import 'package:todo2/database/repository/checklist_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/controller/color_pallete_controller/color_pallete_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/navigation/controllers/inherited_navigation_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/navigation/controllers/navigation_controller.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/services/error_service/error_service.dart';

class AddCheckListController extends ChangeNotifier {
  final _checkListItemsRepository = ChecklistItemsRepositoryImpl();
  final _checkListRepository = CheckListsRepositoryImpl();
  final checkBoxItems = ValueNotifier<List<String>>(['Item index 1']);

  final colorPalleteController = ColorPalleteController();
  final formKey = GlobalKey<FormState>();

  final isClickedButton = ValueNotifier(true);
  bool isChecked = false;

  Future<void> addCheckList({
    required BuildContext context,
    required String title,
  }) async {
    final inheritedNavigatorConroller =
        InheritedNavigator.of(context)!.navigationController;

    if (formKey.currentState!.validate()) {
      isClickedButton.value = false;
      isClickedButton.notifyListeners();
      await putChecklist(
          color: colors[colorPalleteController.selectedIndex.value]
              .value
              .toString(),
          title: title);
      await putChecklistItem();
      await inheritedNavigatorConroller.animateToPage(NavigationPages.tasks);
      isClickedButton.value = true;
      isClickedButton.notifyListeners();
    }
  }

  void addItem(int index) {
    checkBoxItems.value.add('Item index ${index + 1}');
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

  Future<void> putChecklistItem() async {
    try {
      await _checkListItemsRepository.putChecklistItem(
          checkboxItems: checkBoxItems.value);
    } catch (e) {
      ErrorService.printError('Error in repository putChecklistItem: $e');
    }
  }

  Future<void> putChecklist({
    required String color,
    required String title,
  }) async {
    try {
      await _checkListRepository.putCheckList(title: title, color: color);
    } catch (e) {
      ErrorService.printError('Error in repository putChecklistItem: $e');
    }
  }
}
