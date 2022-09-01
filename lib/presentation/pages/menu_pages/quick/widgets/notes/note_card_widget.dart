import 'package:flutter/material.dart';
import 'package:todo2/database/model/notes_model.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/widgets/color_line_widget.dart';

class NoteCardWidget extends StatelessWidget {
  final NotesModel notesModel;
  const NoteCardWidget({
    Key? key,
    required this.notesModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 3,
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
                  fontWeight: FontWeight.w300,
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
