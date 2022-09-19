import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo2/database/model/notes_model.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/note_page/controller/new_note_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/widgets/common_widgets/color_line_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/widgets/common_widgets/shadow_decoration.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/widgets/common_widgets/title_widget.dart';
import 'package:todo2/presentation/widgets/common/slidable_widgets/endpane_widget.dart';
import 'package:todo2/presentation/widgets/common/slidable_widgets/grey_slidable_widget.dart';
import 'package:todo2/presentation/pages/navigation/controllers/navigation_controller.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/utils/assets_path.dart';

class NoteCardWidget extends StatelessWidget {
  final NavigationController navigationController;
  final NotesModel notesModel;
  final NewNoteController noteController;
  const NoteCardWidget({
    Key? key,
    required this.notesModel,
    required this.navigationController,
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
                  onClick: () async {
                    noteController.pickEditData(notesModel: notesModel);
                    await navigationController.moveToPage(Pages.addCheckList);
                  },
                )
              : EndPageWidget(
                  icon: Icons.done,
                  color: Colors.green,
                  onClick: () async {
                    await noteController.updateAsDone(
                      pickedModel: notesModel,
                      context: context,
                    );
                  },
                ),
          const GreySlidableWidget(),
          EndPageWidget(
            iconPath: AssetsPath.editIconPath,
            onClick: () async {
              noteController.pickEditData(notesModel: notesModel);
              await navigationController.moveToPage(Pages.addNote);
            },
          ),
          const GreySlidableWidget(),
          EndPageWidget(
            iconPath: AssetsPath.deleteIconPath,
            onClick: () async {
              await noteController.deleteNote(notesModel: notesModel);
            },
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          width: double.infinity,
          decoration: shadowDecoration,
          child: Stack(
            children: [
              ColorLineWidget(color: notesModel.color),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: TitleWidget(
                  title: notesModel.description,
                  textDecoration: notesModel.isCompleted
                      ? TextDecoration.lineThrough
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
