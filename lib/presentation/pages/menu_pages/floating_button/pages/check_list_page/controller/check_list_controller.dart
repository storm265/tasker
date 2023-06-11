// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/domain/model/checklist_model.dart';
import 'package:todo2/domain/repository/checklist_repository.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/providers/color_pallete_provider/color_pallete_provider.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/controller/quick_controller.dart';
import 'package:todo2/presentation/pages/navigation/controllers/navigation_controller.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/schemas/database_scheme/check_list_items_scheme.dart';
import 'package:todo2/services/message_service/message_service.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/services/network_service/connection_checker.dart';

class CheckListController extends ChangeNotifier with ConnectionCheckerMixin {
  final CheckListRepository _checkListRepository;
  CheckListController({required CheckListRepository checkListRepository})
      : _checkListRepository = checkListRepository;

  final TextEditingController titleController = TextEditingController();

  List<CheckListModel> checklist = [];

  final checkBoxItems = ValueNotifier<List<Map<String, dynamic>>>([]);

  final colorPalleteController = ColorPalleteProvider();

  final formKey = GlobalKey<FormState>();

  CheckListModel? _pickedModel;

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
    if (await isConnected()) {
      try {
        if (formKey.currentState!.validate() &&
            !colorPalleteController.isNotPickerColor) {
          removeItemsWhereTitleIsEmpty();
          FocusScope.of(context).unfocus();
          changeIsClickedValueStatus(false);
          if (isEditStatus.value) {
            await updateCheckList();
            MessageService.displaySnackbar(
              context: context,
              message: LocaleKeys.updated.tr(),
            );
          } else {
            await createCheckList();
            MessageService.displaySnackbar(
              context: context,
              message: LocaleKeys.created.tr(),
            );
          }
          quickController.fetchNotesLocally();
          clearData();
          changeIsClickedValueStatus(true);
          await navigationController.moveToPage(Pages.quick);
        }
      } finally {
        changeIsClickedValueStatus(true);
      }
    } else {
      MessageService.displaySnackbar(
        message: LocaleKeys.no_internet.tr(),
        context: context,
      );
      changeIsClickedValueStatus(true);
    }
  }

  Future<void> createCheckList() async {
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
  }

  Future<void> updateCheckList() async {
    final updatedModel = await _checkListRepository.updateCheckList(
      color: colors[colorPalleteController.selectedIndex.value],
      checklistId: _pickedModel?.id ?? '',
      items: checkBoxItems.value,
      title: titleController.text,
    );
    for (var i = 0; i < checklist.length; i++) {
      if (checklist[i].id == updatedModel.id) {
        checklist[i] = updatedModel;

        break;
      }
    }
  }

  Future<List<CheckListModel>> fetchAllCheckLists() async {
    final lists = await _checkListRepository.fetchAllCheckLists();
    checklist = lists;
    return lists;
  }

  Future<void> deleteChecklistItem({required String checklistItemId}) async {
    await _checkListRepository.deleteCheckListItem(
        checkListId: checklistItemId);
    quickController.fetchNotesLocally();
  }

  Future<void> deleteChecklist({
    required CheckListModel checkListModel,
    required BuildContext context,
  }) async {
    if (await isConnected()) {
      await _checkListRepository.deleteCheckList(
          checkListModel: checkListModel);
      checklist.removeWhere((element) => element.id == checkListModel.id);
      quickController.fetchNotesLocally();
      MessageService.displaySnackbar(
        context: context,
        message: LocaleKeys.deleted.tr(),
      );
    } else {
      MessageService.displaySnackbar(
        message: LocaleKeys.no_internet.tr(),
        context: context,
      );
    }
  }

  void addCheckboxItem(int index) {
    checkBoxItems.value.add({
      CheckListItemsScheme.id: null,
      CheckListItemsScheme.content: checkBoxItems.value.isEmpty
          ? '${LocaleKeys.list_item.tr()} $index'
          : '${LocaleKeys.list_item.tr()} ${index + 1}',
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

  void removeCheckboxItem({
    required int index,
    required BuildContext context,
  }) async {
    if (checkBoxItems.value[index][CheckListItemsScheme.id] == null) {
      checkBoxItems.value.removeAt(index);
    } else {
      if (await isConnected()) {
        await deleteChecklistItem(
            checklistItemId: checkBoxItems.value[index]
                [CheckListItemsScheme.id]);
        checkBoxItems.value.removeAt(index);
        quickController.fetchNotesLocally();
      } else {
        MessageService.displaySnackbar(
          message: LocaleKeys.no_internet.tr(),
          context: context,
        );
        checkBoxItems.notifyListeners();
      }
    }
  }

  void removeItemsWhereTitleIsEmpty() async {
    for (var i = 0; i < checklist.length; i++) {
      checkBoxItems.value.removeWhere(
          (element) => element[CheckListItemsScheme.content].isEmpty);
    }
    checkBoxItems.notifyListeners();
  }
}
