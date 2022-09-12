import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo2/database/model/notes_model.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/note_page/controller/new_note_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/widgets/color_line_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/widgets/shadow_decoration.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/slidable_widgets/endpane_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/slidable_widgets/grey_slidable_widget.dart';
import 'package:todo2/presentation/pages/navigation/controllers/navigation_controller.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';

class NoteCardWidget extends StatelessWidget {
  final NavigationController navigationController;
  final NotesModel notesModel;
  final VoidCallback callback;
  final NewNoteController noteController;
  const NoteCardWidget({
    Key? key,
    required this.notesModel,
    required this.navigationController,
    required this.callback,
    required this.noteController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          notesModel.isCompleted
              ? EndPageWidget(
                  icon: Icons.done,
                  color: Colors.grey,
                  onClick: () {},
                )
              : EndPageWidget(
                  icon: Icons.done,
                  color: Colors.green,
                  onClick: () async {
                    await noteController.updateAsDone(
                      pickedModel: notesModel,
                      context: context,
                    );
                    callback();
                  },
                ),
          const GreySlidableWidget(),
          EndPageWidget(
            icon: Icons.edit,
            onClick: () async {
              noteController.pickEditData(notesModel: notesModel);
              await navigationController.moveToPage(page: Pages.addNote);
            },
          ),
          const GreySlidableWidget(),
          EndPageWidget(
            icon: Icons.delete,
            onClick: () async {
              await noteController.deleteNote(
                notesModel: notesModel,
                context: context,
              );
              callback();
            },
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          decoration: shadowDecoration,
          child: Stack(
            children: [
              ColorLineWidget(color: notesModel.color),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 17,
                  vertical: 8,
                ),
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
