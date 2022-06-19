// ignore_for_file: non_constant_identifier_names

import 'package:todo2/database/database_scheme/notes_scheme.dart';

class NotesModel {
  final String? description, color, created_at, owner_id;

  NotesModel({
    required this.color,
    required this.description,
    required this.created_at,
    required this.owner_id,
  });
  factory NotesModel.fromJson(Map<String, dynamic> json) => NotesModel(
        color: json[NotesScheme.color],
        created_at: json[NotesScheme.createdAt],
        owner_id: json[NotesScheme.ownerId],
        description: json[NotesScheme.description],
      );
}
