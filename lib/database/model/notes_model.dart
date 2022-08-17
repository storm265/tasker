import 'package:todo2/database/database_scheme/notes_scheme.dart';

class NotesModel {
  String description;
  String color;
  String ownerId;
  String createdAt;

  NotesModel({
    required this.color,
    required this.description,
    required this.ownerId,
    required this.createdAt,
  });

  factory NotesModel.fromJson(Map<String, dynamic> json) => NotesModel(
        color: json[NotesScheme.color],
        description: json[NotesScheme.description],
        ownerId: json[NotesScheme.ownerId],
        createdAt: json[NotesScheme.createdAt],
      );
}
