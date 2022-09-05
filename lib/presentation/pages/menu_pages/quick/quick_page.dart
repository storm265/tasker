import 'package:flutter/material.dart';
import 'package:todo2/database/model/checklist_model.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/check_list_page/controller/checklist_singleton.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/note_page/controller/note_singleton.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/controller/quick_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/widgets/checkbox/checkbox_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/widgets/notes/note_card_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/widgets/quick_shimmer_widget.dart';
import 'package:todo2/presentation/pages/navigation/controllers/inherited_navigator.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/presentation/widgets/common/disabled_scroll_glow_widget.dart';
import 'package:todo2/presentation/widgets/common/progress_indicator_widget.dart';

class QuickPage extends StatefulWidget {
  const QuickPage({Key? key}) : super(key: key);

  @override
  State<QuickPage> createState() => _QuickPageState();
}

class _QuickPageState extends State<QuickPage> {
  final _quickController = QuickController(
    checkListController: CheckListSingleton(),
    noteController: NoteSingleton(),
  );

  @override
  Widget build(BuildContext context) {
    final navigationController =
        NavigationInherited.of(context).navigationController;
    return AppbarWrapWidget(
      title: 'Quick Notes',
      isRedAppBar: false,
      child: FutureBuilder<List<dynamic>>(
        future: _quickController.fetchList(),
        builder: ((_, AsyncSnapshot<List<dynamic>> snapshots) => snapshots
                .hasData
            ? DisabledGlowWidget(
                child: ListView.builder(
                  itemCount: snapshots.data!.length,
                  itemBuilder: (_, i) =>
                      snapshots.connectionState == ConnectionState.waiting
                          ? ShimmerQuickItem()
                          : snapshots.data![i] is CheckListModel
                              ? CheckboxWidget(
                                  navigationController: navigationController,
                                  checklistModel: snapshots.data![i],
                                  callback: () => setState(() {}),
                                )
                              : NoteCardWidget(
                                  navigationController: navigationController,
                                  notesModel: snapshots.data![i],
                                  callback: () => setState(() {}),
                                ),
                ),
              )
            : const ProgressIndicatorWidget(text: 'No data')),
      ),
    );
  }
}
