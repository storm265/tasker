// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:todo2/database/data_source/checklists_data_source.dart';
import 'package:todo2/database/data_source/notes_data_source.dart';
import 'package:todo2/database/model/checklist_item_model.dart';
import 'package:todo2/database/model/checklist_model.dart';
import 'package:todo2/database/model/notes_model.dart';
import 'package:todo2/database/repository/checklist_repository.dart';
import 'package:todo2/database/repository/notes_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/add_check_list/controller/check_list_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/controller/notes_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/widgets/note_card.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/widgets/note_card_widget.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/presentation/widgets/common/disabled_scroll_glow_widget.dart';
import 'package:todo2/presentation/widgets/common/progress_indicator_widget.dart';
import 'package:todo2/presentation/widgets/common/will_pop_scope_wrapp.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/storage/secure_storage_service.dart';

class QuickPage extends StatelessWidget {
  QuickPage({Key? key}) : super(key: key);
  //final controller = CheckListLinkedController();
  final _notesController = NotesController(
    notesRepository: NoteRepositoryImpl(
      noteDataSource: NotesDataSourceImpl(
        network: NetworkSource(),
        secureStorage: SecureStorageService(),
      ),
    ),
  );
  final _checkList = AddCheckListController(
      checkListRepository: CheckListRepositoryImpl(
          checkListsDataSource: CheckListsDataSourceImpl(
    network: NetworkSource(),
    secureStorage: SecureStorageService(),
  )));
  // CheckListsRepositoryImpl(
  //     checkListsDataSource: CheckListsDataSourceImpl(
  //   network: NetworkSource(),
  //   secureStorage: SecureStorageService(),
  // ));
  @override
  Widget build(BuildContext context) {
    return AppbarWrapWidget(
      //  child:  SizedBox(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => CheckListsRepositoryImpl(
      //       checkListsDataSource: CheckListsDataSourceImpl(
      //     network: NetworkSource(),
      //     secureStorage: SecureStorageService(),
      //   )).fetchAllCheckLists(),
      // ),
      // floatingActionButton: FloatingActionButton(
      //     onPressed: () => CheckListsDataSourceImpl(
      //         network: NetworkSource(), secureStorage: SecureStorageService()).),
      title: 'Quick Notes',
      isRedAppBar: false,
      child: FutureBuilder<List<CheckListModel>>(
        initialData: const [],
        future: _checkList.fetchAllCheckLists(),
        builder: ((_, AsyncSnapshot<List<CheckListModel>> snapshots) =>
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
      // Notes only
      //     FutureBuilder<List<NotesModel>>(
      //   initialData: const [],
      //   future: _notesController.fetchUserNotes(),
      //   builder: ((_, AsyncSnapshot<List<NotesModel>> snapshots) =>
      //       snapshots.hasData
      //           ? DisabledGlowWidget(
      //               child: ListView.builder(
      //                 itemCount: snapshots.data!.length,
      //                 itemBuilder: (context, index) => NoteCardWidget(
      //                   motesModel: snapshots.data![index],
      //                 ),
      //               ),
      //             )
      //           : const Center(child: ProgressIndicatorWidget())),
      // ),
      //     FutureBuilder<List<NotesModel>>(
      //   initialData: const [],
      //   future: _notesController.fetchUserNotes(),
      //   builder: ((_, AsyncSnapshot<List<NotesModel>> snapshots) =>
      //       snapshots.hasData
      //           ? DisabledGlowWidget(
      //               child: ListView.builder(
      //                 itemCount: snapshots.data!.length,
      //                 itemBuilder: (context, index) => NoteCardWidget(
      //                   motesModel: snapshots.data![index],
      //                 ),
      //               ),
      //             )
      //           : const Center(child: ProgressIndicatorWidget())),
      // ),
    );
  }
}
