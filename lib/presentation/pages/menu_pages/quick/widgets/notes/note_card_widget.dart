import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo2/database/model/notes_model.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/note_page/controller/note_singleton.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/widgets/color_line_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/widgets/shadow_decoration.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/slidable_widgets/endpane_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/slidable_widgets/grey_slidable_widget.dart';
import 'package:todo2/presentation/pages/navigation/controllers/navigation_controller.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';

class NoteCardWidget extends StatelessWidget {
  final NavigationController navigationController;
  final NotesModel notesModel;
  NoteCardWidget({
    Key? key,
    required this.notesModel,
    required this.navigationController,
  }) : super(key: key);
  final _noteController = NoteSingleton().controller;
  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          EndPageWidget(
            icon: Icons.edit,
            onClick: () async {
              _noteController.pickEditData(notesModel: notesModel);
              await navigationController.moveToPage(Pages.addNote);
            },
          ),
          const GreySlidableWidget(),
          EndPageWidget(
            icon: Icons.delete,
            onClick: () {},
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          decoration: shadowDecoration,
          child: Stack(
            children: [
              ColorLineWidget(color: notesModel.color),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  notesModel.description,
                  style: TextStyle(
                    decoration: notesModel.isCompleted
                        ? TextDecoration.lineThrough
                        : null,
                    fontWeight: FontWeight.w200,
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
  }
}
