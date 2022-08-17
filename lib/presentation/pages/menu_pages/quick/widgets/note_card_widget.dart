import 'package:flutter/material.dart';
import 'package:todo2/database/model/notes_model.dart';

class NoteCardWidget extends StatelessWidget {
  final NotesModel motesModel;
  const NoteCardWidget({Key? key, required this.motesModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 3,
        child: SizedBox(
          width: 300,
          height: 100,
          child: Stack(
            children: [
              Positioned(
                top: 1,
                left: 17,
                child: SizedBox(
                  width: 121,
                  height: 3,
                  child: ColoredBox(
                    color: Color(int.parse(motesModel.color)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  motesModel.description,
                  style: const TextStyle(
                    fontWeight: FontWeight.w300,
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
