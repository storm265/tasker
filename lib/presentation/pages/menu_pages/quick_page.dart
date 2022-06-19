import 'package:flutter/material.dart';
import 'package:todo2/database/model/notes_model.dart';
import 'package:todo2/database/repository/checklist_items_repository.dart';
import 'package:todo2/database/repository/checklist_repository.dart';
import 'package:todo2/database/repository/notes_repository.dart';
import 'package:todo2/presentation/widgets/common/appbar_widget.dart';
import 'package:todo2/presentation/widgets/common/will_pop_scope_wrapper.dart';

class QuickPage extends StatelessWidget {
  QuickPage({Key? key}) : super(key: key);
  final _notesRepository = NotesRepositoryImpl();
  final _checkListItem = ChecklistItemsRepositoryImpl();
  final _checkList = CheckListsRepositoryImpl();
  Future<void> dd() async {
    final checkListItem = await _checkListItem.fetchChecklistItem();
    print(checkListItem);
    //  print(_checkListItem.getList());
    //  print(checkListItem);
    // final checkList = await _checkList.fetchCheckList();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWrapper(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async => dd(),
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
