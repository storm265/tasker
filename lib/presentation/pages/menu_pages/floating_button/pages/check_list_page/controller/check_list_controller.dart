import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:todo2/database/data_source/checklists_data_source.dart';
import 'package:todo2/database/database_scheme/check_list_items_scheme.dart';
import 'package:todo2/database/model/checklist_model.dart';
import 'package:todo2/database/repository/checklist_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/controller/color_pallete_controller/color_pallete_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/controller/quick_controller.dart';
import 'package:todo2/presentation/pages/navigation/controllers/navigation_controller.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/storage/secure_storage_service.dart';

class CheckListController extends ChangeNotifier {
  static final CheckListController _instance = CheckListController._internal();
  
  factory CheckListController() {
      log('CheckListController createe');
    return _instance;
  }

  CheckListController._internal();

  
  final _checkListRepository = CheckListRepositoryImpl(
      checkListsDataSource: CheckListsDataSourceImpl(
    network: NetworkSource(),
    secureStorage: SecureStorageSource(),
  ));

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

  void changeEditValueStatus(bool status) {
    isEdit.value = status;
    isEdit.notifyListeners();
  }

  void changeIsClickedValueStatus(bool status) {
    isClickedButton.value = status;
    isClickedButton.notifyListeners();
  }

  void clearData() {
    colorPalleteController.changeSelectedIndex(99);
    checkBoxItems.value.clear();
    checkBoxItems.notifyListeners();
    titleController.clear();
  }

  void removeAllCheckboxItems() async {
    if (isCreateMode()) {
      await deleteChecklistItems(items: checkBoxItems.value);
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
      changeEditValueStatus(false);
      return true;
    } else {
      log('is edit mode');
      changeEditValueStatus(true);
      return false;
    }
  }

  void addCheckboxItem(int index) {
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
        changeIsClickedValueStatus(false);

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
       await quickController.fetchList();
        await navigationController.moveToPage(page: Pages.quick);

        clearData();
        changeIsClickedValueStatus(true);
      }
    } catch (e, t) {
      log('tt $t');
      throw Failure(e.toString());
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

  Future<void> deleteChecklistItem({required String checklistItemId}) async {
    try {
      return _checkListRepository.deleteCheckListItem(
          checkListId: checklistItemId);
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<void> deleteChecklistItems(
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

  Future<void> deleteChecklist({required CheckListModel checkListModel}) async {
    try {
      return _checkListRepository.deleteCheckList(
          checkListModel: checkListModel);
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  void changeCheckboxValue({
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
      removeCheckboxItem(index);
    } else {
      checkBoxItems.value[index][CheckListItemsScheme.content] = title;
    }

    checkBoxItems.notifyListeners();
  }

  void removeCheckboxItem(int index) async {
    if (isEdit.value) {
      await deleteChecklistItem(
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
