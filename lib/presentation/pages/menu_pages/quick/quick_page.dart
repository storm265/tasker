// ignore_for_file: must_be_immutable
import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todo2/database/data_source/checklists_data_source.dart';
import 'package:todo2/database/model/checklist_item_model.dart';
import 'package:todo2/database/model/checklist_model.dart';
import 'package:todo2/database/repository/checklist_items_repository.dart';
import 'package:todo2/database/repository/checklist_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/widgets/checkbox_item_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/widgets/color_line_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/widgets/title_widget.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/presentation/widgets/common/disabled_scroll_glow_widget.dart';
import 'package:todo2/presentation/widgets/common/will_pop_scope_wrapper.dart';

class CheckListLinkedModel {
  CheckListModel checkListModel;
  List<CheckListItemModel> checkListItems;
  CheckListLinkedModel(
      {required this.checkListItems, required this.checkListModel});
}

// create controller
class QuickPage extends StatelessWidget {
  QuickPage({Key? key}) : super(key: key);

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

    List<CheckListItemModel> itemModel = [];
    for (int i = 0; i < checkList.length; i++) {
      CheckListModel model = checkList[i];
      for (int j = 0; j < items.length; j++) {
        if (model.ownerId == items[j].checklistId) {
          itemModel.add(items[j]);
        }
      }
      models.add(CheckListLinkedModel(
          checkListModel: model, checkListItems: itemModel));
    }

    return models;
  }

  final checkListDataSource = CheckListsDataSourceImpl();
  @override
  Widget build(BuildContext context) {
    return WillPopWrapper(
      child: AppbarWrapperWidget(
        title: 'Quick notes',
        statusBarColor: Colors.white,
        titleColor: Colors.black,
        brightness: Brightness.dark,
        child: FutureBuilder<List<CheckListLinkedModel>>(
          initialData: const [],
          future: fetchNotes(),
          builder: ((_, AsyncSnapshot<List<CheckListLinkedModel>> snapshots) {
            return DisabledGlowWidget(
              child: ListView.builder(
                itemCount: snapshots.data!.length,
                itemBuilder: (context, index) {
                  // final data = snapshots.data![index];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 3,
                      child: Stack(
                        children: [
                          ColorLineWidget(
                              color:
                                  snapshots.data![index].checkListModel.color,
                              index: index),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TitleWidget(
                                    title: snapshots
                                        .data![index].checkListModel.title,
                                    index: index),
                                CheckBoxWidget(
                                  data: snapshots.data![index].checkListItems,
                                  index: index,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }),
        ),
      ),
    );
  }
}

// class NoteCard extends StatelessWidget {
//   final int index;
//   final List<CheckListModel> checkListModel;
//   final List<CheckListItemModel> checListItemModel;
//   const NoteCard({
//     Key? key,
//     required this.checListItemModel,
//     required this.checkListModel,
//     required this.index,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Card(
//         elevation: 3,
//         child: Stack(
//           children: [
//             ColorLineWidget(data: checkListModel, index: index),
//             Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   TitleWidget(data: checkListModel, index: index),
//                   CheckBoxWidget(
//                     data: checListItemModel,
//                     index: index,
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
