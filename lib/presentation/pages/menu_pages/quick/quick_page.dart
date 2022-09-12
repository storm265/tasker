import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:todo2/database/model/checklist_model.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/controller/quick_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/widgets/checkbox/checkbox_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/widgets/notes/note_card_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/widgets/quick_shimmer_widget.dart';
import 'package:todo2/presentation/pages/navigation/controllers/inherited_navigator.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/presentation/widgets/common/progress_indicator_widget.dart';

class QuickPage extends StatefulWidget {
  const QuickPage({Key? key}) : super(key: key);

  @override
  State<QuickPage> createState() => QuickPageState();
}

class QuickPageState extends State<QuickPage> {
  final _quickController = QuickController();

  @override
  void dispose() {
    log('quick page is disposed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final navigationController =
        NavigationInherited.of(context).navigationController;
    return AppbarWrapWidget(
      title: 'Quick Notes',
      isRedAppBar: false,
      child: ValueListenableBuilder<List<dynamic>>(
        valueListenable: _quickController.linkedModels,
        builder: ((__, projectsList, _) => projectsList.isEmpty
            ? ListView.builder(
                itemCount: projectsList.length,
                itemBuilder: (_, i) => projectsList.isEmpty
                    ? ShimmerQuickItem()
                    : projectsList[i] is CheckListModel
                        ? CheckboxWidget(
                            navigationController: navigationController,
                            checklistModel: projectsList[i],
                            callback: () => setState(() {}),
                          )
                        : NoteCardWidget(
                            navigationController: navigationController,
                            notesModel: projectsList[i],
                            callback: () => setState(() {}),
                          ),
              )
            : const ProgressIndicatorWidget(text: 'No data')),
      ),
    );
  }
}
