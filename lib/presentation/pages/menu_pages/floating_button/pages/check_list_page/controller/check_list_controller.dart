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
    return _instance;
  }

  CheckListController._internal();

  final _checkListRepository = CheckListRepositoryImpl(
      checkListsDataSource: CheckListsDataSourceImpl(
    network: NetworkSource(),
    secureStorage: SecureStorageSource(),
  ));

  final TextEditingController titleController = TextEditingController();

  List<CheckListModel> checklist = [];

  final checkBoxItems = ValueNotifier<List<Map<String, dynamic>>>([]);

  final colorPalleteController = ColorPalleteController();

  final formKey = GlobalKey<FormState>();

  CheckListModel _pickedModel = CheckListModel(
    id: 'id',
    title: '',
    color: Colors.red,
    ownerId: '',
    createdAt: DateTime(2022),
    items: [],
  );

  final isEditStatus = ValueNotifier(false);
  final isClickedButton = ValueNotifier(true);

  void changeEditValueStatus(bool status) {
    isEditStatus.value = status;
    isEditStatus.notifyListeners();
  }

  void changeIsClickedValueStatus(bool status) {
    isClickedButton.value = status;
    isClickedButton.notifyListeners();
  }

  void clearData() {
    checkBoxItems.value.clear();
    colorPalleteController.changeSelectedIndex(99);
    titleController.clear();
    changeEditValueStatus(false);
  }

  void pickModel({required CheckListModel checklistModel}) =>
      _pickedModel = checklistModel;

  void pickEditData({required CheckListModel pickedModel}) {
    pickModel(checklistModel: pickedModel);
    for (int i = 0; i < colors.length; i++) {
      if (colors[i] == pickedModel.color) {
        colorPalleteController.changeSelectedIndex(i);
        break;
      }
    }
    titleController.text = pickedModel.title;
    for (int i = 0; i < pickedModel.items.length; i++) {
      checkBoxItems.value.add({
        CheckListItemsScheme.id: pickedModel.items[i].id,
        CheckListItemsScheme.isCompleted: pickedModel.items[i].isCompleted,
        CheckListItemsScheme.content: pickedModel.items[i].content,
      });
    }
  }

  Future<void> tryValidateCheckList({
    required BuildContext context,
    required NavigationController navigationController,
  }) async {
    try {
      if (formKey.currentState!.validate() &&
          !colorPalleteController.isNotPickerColor) {
        removeItemsWhereTitleIsEmpty();
        FocusScope.of(context).unfocus();
        changeIsClickedValueStatus(false);
        isEditStatus.value ? await updateCheckList() : await createCheckList();
        log('checkList len : ${checklist.length}');
        quickController.fetchNotesLocally();
        clearData();
        changeIsClickedValueStatus(true);
        log('checkList len2 : ${checklist.length}');
        await navigationController.moveToPage(Pages.quick);
      }
    } catch (e, t) {
      log('tt $t');
      throw Failure(e.toString());
    } finally {
      changeIsClickedValueStatus(true);
    }
  }

  Future<void> createCheckList() async {
    try {
      final model = await _checkListRepository.createCheckList(
        title: titleController.text,
        color: colors[colorPalleteController.selectedIndex.value],
        items: checkBoxItems.value,
      );
      checklist.add(CheckListModel(
        id: model.id,
        title: model.title,
        color: model.color,
        ownerId: model.ownerId,
        createdAt: model.createdAt,
        items: model.items,
      ));
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<void> updateCheckList() async {
    try {
      final updatedModel = await _checkListRepository.updateCheckList(
        color: colors[colorPalleteController.selectedIndex.value],
        checklistId: _pickedModel.id,
        items: checkBoxItems.value,
        title: titleController.text,
      );
      for (var i = 0; i < checklist.length; i++) {
        if (checklist[i].id == updatedModel.id) {
          checklist[i] = updatedModel;

          break;
        }
      }
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<List<CheckListModel>> fetchAllCheckLists() async {
    try {
      final lists = await _checkListRepository.fetchAllCheckLists();
      checklist = lists;

      return lists;
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<void> deleteChecklistItem({required String checklistItemId}) async {
    try {
      await _checkListRepository.deleteCheckListItem(
          checkListId: checklistItemId);
      quickController.fetchNotesLocally();
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<void> deleteChecklist({required CheckListModel checkListModel}) async {
    try {
      await _checkListRepository.deleteCheckList(
          checkListModel: checkListModel);
      checklist.removeWhere((element) => element.id == checkListModel.id);
      quickController.fetchNotesLocally();
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  void addCheckboxItem(int index) {
    checkBoxItems.value.add({
      CheckListItemsScheme.id: null,
      CheckListItemsScheme.content: checkBoxItems.value.isEmpty
          ? 'List item $index'
          : 'List item ${index + 1}',
      CheckListItemsScheme.isCompleted: false,
    });
    checkBoxItems.notifyListeners();
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
    checkBoxItems.value[index][CheckListItemsScheme.content] = title;
    checkBoxItems.notifyListeners();
  }

  void removeCheckboxItem(int index) async {
    if (checkBoxItems.value[index][CheckListItemsScheme.id] == null) {
      checkBoxItems.value.removeAt(index);
    } else {
      await deleteChecklistItem(
          checklistItemId: checkBoxItems.value[index][CheckListItemsScheme.id]);
      checkBoxItems.value.removeAt(index);
      quickController.fetchNotesLocally();
    }
    checkBoxItems.notifyListeners();
  }

  void removeItemsWhereTitleIsEmpty() async {
    for (var i = 0; i < checklist.length; i++) {
      checkBoxItems.value.removeWhere(
          (element) => element[CheckListItemsScheme.content].isEmpty);
    }
    checkBoxItems.notifyListeners();
  }
}
