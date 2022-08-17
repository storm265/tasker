// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:todo2/database/model/checklist_item_model.dart';
import 'package:todo2/database/model/checklist_model.dart';
import 'package:todo2/database/repository/checklist_items_repository.dart';
import 'package:todo2/database/repository/checklist_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/widgets/note_card.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/presentation/widgets/common/disabled_scroll_glow_widget.dart';
import 'package:todo2/presentation/widgets/common/progress_indicator_widget.dart';
import 'package:todo2/presentation/widgets/common/will_pop_scope_wrapper.dart';

class CheckListLinkedModel {
  final CheckListModel checkListModel;
  final List<CheckListItemModel> checkListItems;
  CheckListLinkedModel({
    required this.checkListModel,
    this.checkListItems = const [],
  });
}

class CheckListLinkedController {
  final _checkListItem = ChecklistItemsRepositoryImpl();
  final _checkList = CheckListsRepositoryImpl();

  List<CheckListLinkedModel> models = [];

  Future<List<CheckListLinkedModel>> fetchNotes() async {
    final List<dynamic> notes = await Future.wait(
      [
        _checkList.fetchCheckList(),
        _checkListItem.fetchCheckListItem(),
      ],
    );
    List<CheckListModel> checkList = notes[0];
    List<CheckListItemModel> items = notes[1];

    for (int i = 0; i < checkList.length; i++) {
      List<CheckListItemModel> itemModel = [];
      CheckListModel model = checkList[i];
      for (int j = 0; j < items.length; j++) {
        if (model.id == items[j].checklistId) {
          itemModel.add(items[j]);
        }
      }
      models.add(CheckListLinkedModel(
          checkListModel: model, checkListItems: itemModel));
    }
    return models;
  }
}

// TODo create controller
class QuickPage extends StatelessWidget {
  QuickPage({Key? key}) : super(key: key);
  final controller = CheckListLinkedController();

  @override
  Widget build(BuildContext context) {
    return WillPopWrapper(
      child: AppbarWrapperWidget(
        title: 'Quick Notes',
        isRedAppBar: false,
        child: FutureBuilder<List<CheckListLinkedModel>>(
          initialData: const [],
          future: controller.fetchNotes(),
          builder: ((_, AsyncSnapshot<List<CheckListLinkedModel>> snapshots) =>
              snapshots.hasData
                  ? DisabledGlowWidget(
                      child: ListView.builder(
                        itemCount: snapshots.data!.length,
                        itemBuilder: (context, index) => NoteCard(
                          model: snapshots.data!,
                          index: index,
                        ),
                      ),
                    )
                  : const Center(child: ProgressIndicatorWidget())),
        ),
      ),
    );
  }
}
