import 'package:flutter/material.dart';
import 'package:todo2/database/database_scheme/notes_scheme.dart';
import 'package:todo2/utils/extensions/color_extension/color_string_extension.dart';

class NotesModel {
  final bool isCompleted;
  final String description;
  final Color color;
  final String ownerId;
  final String createdAt;

  NotesModel({
    required this.isCompleted,
    required this.color,
    required this.description,
    required this.ownerId,
    required this.createdAt,
  });

  factory NotesModel.fromJson(Map<String, dynamic> json) => NotesModel(
        isCompleted: json[NotesScheme.isCompleted],
        color: Color(
          int.parse(json[NotesScheme.color].toString().replaceColorSymbol()),
        ),
        description: json[NotesScheme.description],
        ownerId: json[NotesScheme.ownerId],
        createdAt: json[NotesScheme.createdAt],
      );
}
