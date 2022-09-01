import 'package:flutter/material.dart';
import 'package:todo2/database/model/notes_model.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/widgets/color_line_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/widgets/shadow_decoration.dart';
import 'package:todo2/presentation/pages/navigation/controllers/navigation_controller.dart';

class NoteCardWidget extends StatelessWidget {
  final NavigationController navigationController;
  final NotesModel notesModel;
  const NoteCardWidget({
    Key? key,
    required this.notesModel,
    required this.navigationController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
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
    );
  }
}
