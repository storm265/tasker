// ignore_for_file: must_be_immutable
import 'dart:developer';

import 'package:flutter/material.dart';
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

// create controller
class QuickPage extends StatelessWidget {
  QuickPage({Key? key}) : super(key: key);

  final _checkListItem = ChecklistItemsRepositoryImpl();
  final _checkList = CheckListsRepositoryImpl();

  List<CheckListItemModel> checListItemModel = [];
  List<CheckListModel> checkListModel = [];

  Future<List<dynamic>> fetchNotes() async {
    final List<dynamic> notes = await Future.wait(
      [
        _checkList.fetchCheckList(),
        _checkListItem.fetchCheckListItem(),
      ],
    );
    checkListModel = notes[0];
    checListItemModel = notes[1];
    log([...checkListModel, ...checListItemModel].toString());

    return [...checkListModel, ...checListItemModel];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWrapper(
      child: AppbarWrapperWidget(
        title: 'Quick notes',
        appBarColor: Colors.white,
        child: FutureBuilder<List<dynamic>>(
          initialData: const [],
          future: fetchNotes(),
          builder: ((_, AsyncSnapshot<List<dynamic>> snapshots) {
            return DisabledGlowWidget(
              child: ListView.builder(
                itemCount: checkListModel.length,
                itemBuilder: (context, index) {
                  // final data = snapshots.data![index];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 3,
                      child: Stack(
                        children: [
                          ColorLineWidget(data: checkListModel, index: index),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TitleWidget(data: checkListModel, index: index),
                                CheckBoxWidget(
                                  data: checListItemModel,
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

class NoteCard extends StatelessWidget {
  final int index;
  final List<CheckListModel> checkListModel;
  final List<CheckListItemModel> checListItemModel;
  const NoteCard({
    Key? key,
    required this.checListItemModel,
    required this.checkListModel,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 3,
        child: Stack(
          children: [
            ColorLineWidget(data: checkListModel, index: index),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TitleWidget(data: checkListModel, index: index),
                  CheckBoxWidget(
                    data: checListItemModel,
                    index: index,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
