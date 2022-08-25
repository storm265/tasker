// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:todo2/database/data_source/notes_data_source.dart';
import 'package:todo2/database/model/checklist_item_model.dart';
import 'package:todo2/database/model/checklist_model.dart';
import 'package:todo2/database/model/notes_model.dart';
import 'package:todo2/database/repository/checklist_items_repository.dart';
import 'package:todo2/database/repository/checklist_repository.dart';
import 'package:todo2/database/repository/notes_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/controller/notes_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/widgets/note_card.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/presentation/widgets/common/disabled_scroll_glow_widget.dart';
import 'package:todo2/presentation/widgets/common/progress_indicator_widget.dart';
import 'package:todo2/presentation/widgets/common/will_pop_scope_wrapp.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/storage/secure_storage_service.dart';

class CheckListLinkedModel {
  final CheckListModel checkListModel;
  final List<CheckListItemModel> checkListItems;
  CheckListLinkedModel({
    required this.checkListModel,
    this.checkListItems = const [],
  });
}

class CheckListLinkedController {
  // final _checkListItem = ChecklistItemsRepositoryImpl();
  // final _checkList = CheckListsRepositoryImpl();

  // List<CheckListLinkedModel> models = [];

  // Future<List<CheckListLinkedModel>> fetchNotes() async {
  //   final List<dynamic> notes = await Future.wait(
  //     [
  //       _checkList.fetchCheckList(),
  //       _checkListItem.fetchCheckListItem(),
  //     ],
  //   );
  //   List<CheckListModel> checkList = notes[0];
  //   List<CheckListItemModel> items = notes[1];

  //   for (int i = 0; i < checkList.length; i++) {
  //     List<CheckListItemModel> itemModel = [];
  //     CheckListModel model = checkList[i];
  //     for (int j = 0; j < items.length; j++) {
  //       if (model.id == items[j].checklistId) {
  //         itemModel.add(items[j]);
  //       }
  //     }
  //     models.add(CheckListLinkedModel(
  //         checkListModel: model, checkListItems: itemModel));
  //   }
  //   return models;
  // }
}

// TODo create controller
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
  @override
  Widget build(BuildContext context) {
    return AppbarWrapWidget(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // '70432b22-a3ca-44c6-ab7b-e1d583766ab0'
            _notesController.updateNote(
                noteModel: NotesModel(

                  id: '1477fcbd-958a-4aa0-a51f-a6fcacc45a25',
                    isCompleted: false,
                    color: Color(0xFF6074F9),
                    description: 'update test',
                    ownerId: 'fbd1792c-dfa4-4507-b3ff-5ea561c416e1',
                    createdAt: '2022-08-25T18:42:39.859966'));
          },
        ),
        title: 'Quick Notes',
        isRedAppBar: false,
        child: SizedBox()
        // FutureBuilder<List<CheckListLinkedModel>>(
        //   initialData: const [],
        //   future: controller.fetchNotes(),
        //   builder: ((_, AsyncSnapshot<List<CheckListLinkedModel>> snapshots) =>
        //       snapshots.hasData
        //           ? DisabledGlowWidget(
        //               child: ListView.builder(
        //                 itemCount: snapshots.data!.length,
        //                 itemBuilder: (context, index) => NoteCard(
        //                   model: snapshots.data!,
        //                   index: index,
        //                 ),
        //               ),
        //             )
        //           : const Center(child: ProgressIndicatorWidget())),
        // ),
        );
  }
}
