
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:todo2/database/model/checklist_item_model.dart';
import 'package:todo2/database/model/checklist_model.dart';
import 'package:todo2/database/repository/checklist_items_repository.dart';
import 'package:todo2/database/repository/checklist_repository.dart';
import 'package:todo2/presentation/widgets/common/appbar_widget.dart';
import 'package:todo2/presentation/widgets/common/disabled_glow_single_child_scroll_widget.dart';
import 'package:todo2/presentation/widgets/common/will_pop_scope_wrapper.dart';

class QuickPage extends StatelessWidget {
  QuickPage({Key? key}) : super(key: key);

  final _checkListItem = ChecklistItemsRepositoryImpl();
  final _checkList = CheckListsRepositoryImpl();

  int checkListItemLen = 0;
  List<CheckListItemModel> checListItemModel = [];
  Future<List<CheckListModel>> fetchListModel() async {
    checListItemModel = await _checkListItem.fetchCheckListItem();
    for (int i = 0; i < checListItemModel.length; i++) {
      checkListItemLen++;
    }
    return _checkList.fetchCheckList();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWrapper(
      child: Scaffold(
        appBar: const AppbarWidget(
          title: 'Quick notes',
          appBarColor: Colors.white,
        ),
        body: FutureBuilder<List<dynamic>>(
          initialData: const [],
          future: fetchListModel(),
          builder: ((_, AsyncSnapshot<List<dynamic>> snapshots) {
            return DisabledGlowWidget(
              child: ListView.builder(
                itemCount: snapshots.data!.length,
                itemBuilder: (context, index) {
                  final data = snapshots.data![index];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 3,
                      child: SizedBox(
                        width: 300,
                        height: checkListItemLen > 0 ? 220 : 100,
                        child: Stack(
                          children: [
                            (data is CheckListModel)
                                ? Positioned(
                                    top: 1,
                                    left: 17,
                                    child: SizedBox(
                                      width: 121,
                                      height: 3,
                                      child: ColoredBox(
                                        color: Color(
                                          int.parse(data.color),
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                            Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      (data is CheckListModel)
                                          ? data.title 
                                          : 'empty',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount: checkListItemLen,
                                        itemBuilder: (context, index) {
                                          final _data =
                                              checListItemModel[index];
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 8,
                                            ),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 12,
                                                  height: 12,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.grey,
                                                      width: 0.5,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3),
                                                    color: _data.isCompleted
                                                        ? Colors.grey
                                                        : Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  _data.createdAt,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    decoration:
                                                        _data.isCompleted
                                                            ? TextDecoration
                                                                .lineThrough
                                                            : null,
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        }),
                                  ],
                                )),
                          ],
                        ),
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
