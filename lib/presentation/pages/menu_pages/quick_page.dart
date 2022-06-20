import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo2/database/model/checklist_and_checklist_item_model.dart';
import 'package:todo2/database/model/checklist_item_model.dart';
import 'package:todo2/database/model/checklist_model.dart';
import 'package:todo2/database/model/notes_model.dart';
import 'package:todo2/database/repository/checklist_items_repository.dart';
import 'package:todo2/database/repository/checklist_repository.dart';
import 'package:todo2/database/repository/notes_repository.dart';
import 'package:todo2/presentation/widgets/common/appbar_widget.dart';
import 'package:todo2/presentation/widgets/common/will_pop_scope_wrapper.dart';

class QuickPage extends StatelessWidget {
  QuickPage({Key? key}) : super(key: key);
  // final _notesRepository = NoteRepositoryImpl();
  // final _checkListItem = ChecklistItemsRepositoryImpl();
  // final _checkList = CheckListsRepositoryImpl();

  Future<void> get2Methods() async {
    // List<dynamic> list = await Future.wait(
    //     [_checkListItem.fetchChecklistItem(), _checkList.fetchCheckList()]);
    List<dynamic> list = [
      CheckListItemAndCheckListModel(
        checklistId: 0,
        title: 'title',
        color: 'color',
        ownerId: 'ownerId',
        content: 'content',
        isCompleted: false,
      )
    ];
    
    final rez =
        list.map((e) => CheckListItemAndCheckListModel.fromJson(e)).toList();
    print(rez);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWrapper(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () async => get2Methods(),
          ),
          appBar:  AppbarWidget(
            title: 'Quick notes',
            appBarColor: Colors.white,
          ),
          body: SizedBox()
          //  FutureBuilder<List<dynamic>>(
          //   initialData: const [],
          //   future: Future.wait([
          //     _checkListItem.fetchChecklistItem(), // CheckListItemModel
          //     _checkList.fetchCheckList() // CheckListModel
          //   ]),
          //   builder: ((_, AsyncSnapshot<List<dynamic>> snapshots) {
          //     return ListView.builder(
          //       itemCount: snapshots.data!.length,
          //       itemBuilder: (context, index) {
          //         final _data = snapshots.data![index];

          //         return ListTile(
          //           title: Text(
          //             _data is CheckListModel ? _data.title : _data.content,
          //           ),
          //         );
          //       },
          //     );
          //   }),
          // ),
          ),
    );
  }
}
/*

*/



// old
/*
import 'package:flutter/material.dart';
import 'package:todo2/database/model/notes_model.dart';
import 'package:todo2/database/repository/notes_repository.dart';
import 'package:todo2/presentation/widgets/common/appbar_widget.dart';
import 'package:todo2/presentation/widgets/common/will_pop_scope_wrapper.dart';

class QuickPage extends StatelessWidget {
  QuickPage({Key? key}) : super(key: key);
  final _notesRepository = NotesRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return WillPopWrapper(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async => _notesRepository.fetchNotes(),
        ),
        appBar: const AppbarWidget(
          title: 'Quick notes',
          appBarColor: Colors.white,
        ),
        body: FutureBuilder(
          future: _notesRepository.fetchNotes(),
          builder: ((_, AsyncSnapshot<List<NotesModel>> snapshots) {
            return snapshots.hasData
                ? ListView.builder(
                    itemCount: snapshots.data!.length,
                    itemBuilder: (context, index) {
                      final _data = snapshots.data![index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 3,
                          child: SizedBox(
                            width: 300,
                            height: 100,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 1,
                                  left: 17,
                                  child: SizedBox(
                                    width: 121,
                                    height: 3,
                                    child: ColoredBox(
                                      color: Color(
                                        int.parse(_data.color!),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    _data.description ?? 'empty',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    })
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          }),
        ),
      ),
    );
  }
}

*/
