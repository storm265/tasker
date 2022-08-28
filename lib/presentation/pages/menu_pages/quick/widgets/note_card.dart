import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo2/database/model/notes_model.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/quick_page.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/widgets/checkbox_item_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/widgets/color_line_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/widgets/title_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/slidable_widgets/endpane_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/slidable_widgets/grey_slidable_widget.dart';

class NoteCard extends StatelessWidget {
  final int index;
  final NotesModel model;
  const NoteCard({
    Key? key,
    required this.model,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            EndPageWidget(
              icon: Icons.edit,
              onClick: () {},
            ),
            const GreySlidableWidget(),
            EndPageWidget(
              icon: Icons.delete,
              onClick: () {},
            ),
          ],
        ),
        child: Card(
          elevation: 3,
          child: Stack(
            children: [
              // ColorLineWidget(color: model[index].checkListModel.color),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TitleWidget(title: model.description),
                   // CheckBoxWidget(data: model[index].checkListItems),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
