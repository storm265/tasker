import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo2/database/model/checklist_model.dart';
import 'package:todo2/database/repository/checklist_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/controller/color_pallete_controller/color_pallete_controller.dart';
import 'package:todo2/presentation/pages/navigation/controllers/navigation_controller.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/message_service/message_service.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';

const isCompleted = 'is_completed';
const content = 'content';
const id = 'id';

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
    if (isEditMode()) {
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
        id: checklistModel.items[i].id,
        isCompleted: checklistModel.items[i].isCompleted,
        content: checklistModel.items[i].content,
      });
    }
    checkBoxItems.notifyListeners();
  }

  bool isEditMode() {
    if (checkBoxItems.value.isEmpty) {
      changeEditStatus(false);
      return false;
    } else {
      changeEditStatus(true);
      return true;
    }
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

        if (isEditMode()) {
          log('isEditMode ${isEditMode()}');
          await updateCheckList().then((value) {
            navigationController.moveToPage(Pages.quick);
          });
        } else {
          bool isDublicated =
              await isSameProjectCreated(checkListId: _pickedModel.value.id);
          log('isDublicated $isDublicated');

          if (isDublicated) {
            MessageService.displaySnackbar(
              context: context,
              message: 'This checklist it already created.',
            );
          } else {
            await createCheckList(
              title: title,
              color: color,
              items: checkBoxItems.value,
            ).then((_) {
              navigationController.moveToPage(Pages.quick);
            });
          }
        }

        clearData();
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

  Future<void> updateCheckList() async {
    try {
      await _checkListRepository.updateCheckList(
        checkListModel: _pickedModel.value,
        items: checkBoxItems.value,
      );
    } catch (e) {
      throw Failure(e.toString());
    }
  }


  Future<bool> isSameProjectCreated({required String checkListId}) async {
    try {
      List<CheckListModel> checkLists = await fetchAllCheckLists();
      for (int i = 0; i < checkLists.length; i++) {
        if (checkListId == checkLists[i].id) {
          return true;
        }
      }
      return false;
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
        idItems.add(items[i][id]);
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
    checkBoxItems.value[index][isCompleted] = value;
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

  void removeItem(int index) async {
    if (isEditMode()) {
      await deleteCheckListItem(
          checklistItemId: checkBoxItems.value[index][id]);
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
