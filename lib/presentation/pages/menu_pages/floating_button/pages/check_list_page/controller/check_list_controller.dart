import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:todo2/database/database_scheme/check_list_items_scheme.dart';
import 'package:todo2/database/model/checklist_model.dart';
import 'package:todo2/database/repository/checklist_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/controller/color_pallete_controller/color_pallete_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/quick_page.dart';
import 'package:todo2/presentation/pages/navigation/controllers/navigation_controller.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';

class AddCheckListController extends ChangeNotifier {
  final CheckListRepositoryImpl _checkListRepository;
  AddCheckListController({required CheckListRepositoryImpl checkListRepository})
      : _checkListRepository = checkListRepository;

  final TextEditingController titleController = TextEditingController();
  final checkBoxItems = ValueNotifier<List<Map<String, dynamic>>>([]);

  final colorPalleteController = ColorPalleteController();
  final formKey = GlobalKey<FormState>();

  final _pickedModel = ValueNotifier<CheckListModel>(
    CheckListModel(
      id: 'id',
      title: '',
      color: Colors.red,
      ownerId: '',
      createdAt: '',
      items: [],
    ),
  );

  final isEdit = ValueNotifier(false);
  final isClickedButton = ValueNotifier(true);
  final isChecked = false;

  void changeButtonStatus(bool status) {
    isClickedButton.value = status;
    isClickedButton.notifyListeners();
  }

  void clearData() {
    colorPalleteController.changeSelectedIndex(99);
    checkBoxItems.value.clear();
    checkBoxItems.notifyListeners();
    titleController.clear();
  }

  void changeEditStatus(bool status) {
    isEdit.value = status;
    isEdit.notifyListeners();
  }

  void removeAllItems() async {
    if (isCreateMode()) {
      await deleteCheckListItems(items: checkBoxItems.value);
      checkBoxItems.value.clear();
    } else {
      checkBoxItems.value.clear();
    }

    checkBoxItems.notifyListeners();
  }

  void pickModel({required CheckListModel checklistModel}) {
    _pickedModel.value = checklistModel;
    _pickedModel.notifyListeners();
  }

  void pickEditData({required CheckListModel checklistModel}) {
    pickModel(checklistModel: checklistModel);
    for (int i = 0; i < colors.length; i++) {
      if (colors[i] == checklistModel.color) {
        colorPalleteController.changeSelectedIndex(i);
        break;
      }
    }
    titleController.text = checklistModel.title;
    for (int i = 0; i < checklistModel.items.length; i++) {
      checkBoxItems.value.add({
        CheckListItemsScheme.id: checklistModel.items[i].id,
        CheckListItemsScheme.isCompleted: checklistModel.items[i].isCompleted,
        CheckListItemsScheme.content: checklistModel.items[i].content,
      });
    }
    checkBoxItems.notifyListeners();
  }

  bool isCreateMode() {
    if (titleController.text.isEmpty) {
      log('is create mode');
      changeEditStatus(false);
      return true;
    } else {
      log('is edit mode');
      changeEditStatus(true);
      return false;
    }
  }

  void addItem(int index) {
    checkBoxItems.value.add({
      CheckListItemsScheme.id: null,
      CheckListItemsScheme.content: checkBoxItems.value.isEmpty
          ? 'List item 1'
          : 'List item ${index + 1 + 1}',
      CheckListItemsScheme.isCompleted: false,
    });
    checkBoxItems.notifyListeners();
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

        if (isCreateMode()) {
          log('edit ');
          await createCheckList(
            title: title,
            color: color,
            items: checkBoxItems.value,
          );
        } else {
          await updateCheckList();
        }

        navigationController.moveToPage(Pages.quick);
        // QuickPage.of(context).updateState();

        clearData();
        changeButtonStatus(true);
      }
    } catch (e, t) {
      log('tt $t');
      throw Failure(e.toString());
    }
  }

  void toDO(
    BuildContext context,
    NavigationController navigationController,
  ) async {
    try {
      // navigationController.moveToPage(Pages.quick);
      //  QuickPage.of(context).updateState();
      final s1 = context.findAncestorStateOfType<QuickPageState>();
      log('s1: $s1');
      final s2 = context.findAncestorStateOfType<QuickPageState>();
      log('s2: $s2');
      final s3 = context.findRootAncestorStateOfType<QuickPageState>();
      log('s3: $s3');
      final s4 = context.findRootAncestorStateOfType<QuickPageState>();
      log('s4: $s4');

      
    } catch (e, t) {
      log('error $e');
      log('trace $t');
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

  Future<void> updateCheckList() async {
    try {
      log('updateCheckList');
      await _checkListRepository.updateCheckList(
        checkListModel: _pickedModel.value,
        items: checkBoxItems.value,
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

  Future<void> deleteCheckListItem({required String checklistItemId}) async {
    try {
      return _checkListRepository.deleteCheckListItem(
          checkListId: checklistItemId);
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<void> deleteCheckListItems(
      {required List<Map<String, dynamic>> items}) async {
    try {
      List<String> idItems = [];
      for (int i = 0; i < items.length; i++) {
        idItems.add(items[i][CheckListItemsScheme.id]);
      }
      return _checkListRepository.deleteCheckListItems(items: idItems);
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<void> deleteCheckList({required CheckListModel checkListModel}) async {
    try {
      return _checkListRepository.deleteCheckList(
          checkListModel: checkListModel);
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  void changeCheckBoxValue({
    required int index,
    required bool? value,
  }) {
    checkBoxItems.value[index][CheckListItemsScheme.isCompleted] = value;
    checkBoxItems.notifyListeners();
  }

  void changeCheckboxText({
    required int index,
    required String title,
  }) {
    if (title.isEmpty) {
      removeItem(index);
    } else {
      checkBoxItems.value[index][CheckListItemsScheme.content] = title;
    }

    checkBoxItems.notifyListeners();
  }

  void removeItem(int index) async {
    if (isEdit.value) {
      await deleteCheckListItem(
          checklistItemId: checkBoxItems.value[index][CheckListItemsScheme.id]);
      checkBoxItems.value.removeAt(index);
      log('removed future item');
    } else {
      checkBoxItems.value.removeAt(index);
    }
    checkBoxItems.notifyListeners();
  }

  void disposeValues() {
    checkBoxItems.dispose();
    titleController.dispose();
    colorPalleteController.disposeValues();
    colorPalleteController.dispose();
    isClickedButton.dispose();
  }
}
