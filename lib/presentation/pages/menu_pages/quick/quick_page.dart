import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/database/model/checklist_model.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/controller/quick_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/widgets/checkbox/checkbox_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/widgets/notes/note_card_widget.dart';
import 'package:todo2/presentation/pages/navigation/controllers/inherited_navigator.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/presentation/widgets/common/activity_indicator_widget.dart';

class QuickPage extends StatefulWidget {
  const QuickPage({Key? key}) : super(key: key);

  @override
  State<QuickPage> createState() => _QuickPageState();
}

class _QuickPageState extends State<QuickPage> {
  @override
  void initState() {
    quickController.fetchNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final navigationController =
        NavigationInherited.of(context).navigationController;
    return AppbarWrapWidget(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await quickController.fetchNotes();
        },
      ),
      title: LocaleKeys.quick_notes.tr(),
      isRedAppBar: false,
      child: ValueListenableBuilder<List<dynamic>>(
        valueListenable: quickController.linkedModels,
        builder: ((__, projectsList, _) => projectsList.isEmpty
            ? ActivityIndicatorWidget(text: LocaleKeys.no_data.tr())
            : ListView.builder(
                itemCount: projectsList.length,
                itemBuilder: (_, i) => projectsList[i] is CheckListModel
                    ? CheckboxWidget(
                        navigationController: navigationController,
                        checklistModel: projectsList[i],
                        checkListController:
                            quickController.checkListController,
                      )
                    : NoteCardWidget(
                        navigationController: navigationController,
                        notesModel: projectsList[i],
                        noteController: quickController.noteController,
                      ),
              )),
      ),
    );
  }
}
