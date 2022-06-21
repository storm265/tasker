import 'package:todo2/database/database_scheme/notes_scheme.dart';

class NotesModel {
  final String? description, color, createdAt, ownerId;

  NotesModel({
    required this.color,
    required this.description,
    required this.createdAt,
    required this.ownerId,
  });
  factory NotesModel.fromJson(Map<String, dynamic> json) => NotesModel(
        color: json[NotesScheme.color],
        createdAt: json[NotesScheme.createdAt],
        ownerId: json[NotesScheme.ownerId],
        description: json[NotesScheme.description],
      );
}
