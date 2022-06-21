import 'package:todo2/database/database_scheme/quick_note_scheme.dart';

class QuickNoteModel {
  int? checklistId;
  String? title;
  String? color;
  String? ownerId;
  String? content;
  bool? isCompleted;

  QuickNoteModel({
    this.checklistId,
    this.title,
    this.color,
    this.ownerId,
    this.content,
    this.isCompleted,
  });

  factory QuickNoteModel.fromJson(Map<String, dynamic> json) => QuickNoteModel(
        checklistId: json[QuickNoteScheme.checklistId],
        title: json[QuickNoteScheme.title],
        color: json[QuickNoteScheme.color],
        ownerId: json[QuickNoteScheme.ownerId],
        content: json[QuickNoteScheme.content],
        isCompleted: json[QuickNoteScheme.isCompleted],
      );
}
