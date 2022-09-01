// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:todo2/database/model/checklist_model.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/controller/quick_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/widgets/checkbox/checkbox_card.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/widgets/notes/note_card_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/widgets/quick_shimmer_widget.dart';
import 'package:todo2/presentation/pages/navigation/controllers/inherited_navigator.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/presentation/widgets/common/disabled_scroll_glow_widget.dart';

class QuickPage extends StatelessWidget {
  QuickPage({Key? key}) : super(key: key);
  final _quickController = QuickController();

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
                  itemBuilder: (context, index) =>
                      snapshots.connectionState == ConnectionState.waiting
                          ? ShimmerQuickItem()
                          : snapshots.data![index] is CheckListModel
                              ? CheckBoxCard(
                                  navigationController: navigationController,
                                  checklistModel: snapshots.data![index],
                                )
                              : NoteCardWidget(
                                  navigationController: navigationController,
                                  notesModel: snapshots.data![index],
                                ),
                ),
              )
            : const Center(
                child: Text('No data'),
              )),
      ),
    );
  }
}
