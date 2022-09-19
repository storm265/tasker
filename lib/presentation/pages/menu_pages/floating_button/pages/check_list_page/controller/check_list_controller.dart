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

  final checklist = ValueNotifier<List<CheckListModel>>([]);

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
    colorPalleteController.changeSelectedIndex(99);
    checklist.value.clear();
    checklist.notifyListeners();
    titleController.clear();
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
      checklist.value.add({
        CheckListItemsScheme.id: pickedModel.items[i].id,
        CheckListItemsScheme.isCompleted: pickedModel.items[i].isCompleted,
        CheckListItemsScheme.content: pickedModel.items[i].content,
      });
    }
    checklist.notifyListeners();
  }

  void addCheckboxItem(int index) {
    checklist.value.add({
      CheckListItemsScheme.id: null,
      CheckListItemsScheme.content: checklist.value.isEmpty
          ? 'List item 1'
          : 'List item ${index + 1 + 1}',
      CheckListItemsScheme.isCompleted: false,
    });
    checklist.notifyListeners();
  }

  Future<void> tryValidateCheckList({
    required BuildContext context,
    List<Map<String, dynamic>>? items,
    required NavigationController navigationController,
  }) async {
    try {
      if (formKey.currentState!.validate() &&
          !colorPalleteController.isNotPickerColor) {
        removeItemsWhereTitleIsEmpty();
        FocusScope.of(context).unfocus();
        changeIsClickedValueStatus(false);
        isEditStatus.value
            ? await updateCheckList()
            : await createCheckList(
                items: checklist.value,
              );

        clearData();
        changeIsClickedValueStatus(true);
        await navigationController.moveToPage(Pages.quick);
      }
    } catch (e, t) {
      log('tt $t');
      throw Failure(e.toString());
    } finally {
      changeIsClickedValueStatus(true);
    }
  }

  Future<void> createCheckList({List<Map<String, dynamic>>? items}) async {
    try {
      final model = await _checkListRepository.createCheckList(
        title: titleController.text,
        color: colors[colorPalleteController.selectedIndex.value],
        items: items,
      );
      checklist.value.add(model);
      checklist.notifyListeners();
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<void> updateCheckList() async {
    try {
      final updatedModel = await _checkListRepository.updateCheckList(
        color: colors[colorPalleteController.selectedIndex.value],
        checkListModel: _pickedModel,
        items: checklist.value,
        title: titleController.text,
      );
         for (var i = 0; i < userNotes.length; i++) {
        if (userNotes[i].id == newModel.id) {
          userNotes[i] = newModel;
          break;
        }
      }
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
    checklist.value[index][CheckListItemsScheme.isCompleted] = value;
    checklist.notifyListeners();
  }

  void changeCheckboxText({
    required int index,
    required String title,
  }) {
    checklist.value[index][CheckListItemsScheme.content] = title;
    checklist.notifyListeners();
  }

  void removeCheckboxItem(int index) async {
    if (checklist.value[index][CheckListItemsScheme.id] == null) {
      checklist.value.removeAt(index);
    } else {
      await deleteChecklistItem(
          checklistItemId: checklist.value[index][CheckListItemsScheme.id]);
      checklist.value.removeAt(index);
    }
    checklist.notifyListeners();
  }

  void removeItemsWhereTitleIsEmpty() async {
    for (var i = 0; i < checklist.value.length; i++) {
      checklist.value.removeWhere(
          (element) => element[CheckListItemsScheme.content].isEmpty);
    }
    checklist.notifyListeners();
  }

  void disposeValues() {
    checklist.dispose();
    titleController.dispose();
    colorPalleteController.disposeValues();
    colorPalleteController.dispose();
    isClickedButton.dispose();
  }
}
