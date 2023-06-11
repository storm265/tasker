import 'package:flutter/material.dart';
import 'package:todo2/schemas/database_scheme/notes_scheme.dart';
import 'package:todo2/utils/extensions/color_extension/color_string_extension.dart';

class NotesModel {
  final String id;
  final bool isCompleted;
  final String description;
  final Color color;
  final String ownerId;
  final DateTime createdAt;

  NotesModel({
    required this.id,
    required this.isCompleted,
    required this.color,
    required this.description,
    required this.ownerId,
    required this.createdAt,
  });

  factory NotesModel.fromJson(Map<String, dynamic> json) => NotesModel(
        id: json[NotesScheme.id],
        isCompleted: json[NotesScheme.isCompleted],
        color: Color(
          int.parse(json[NotesScheme.color].toString().replaceColorSymbol()),
        ),
        description: json[NotesScheme.description],
        ownerId: json[NotesScheme.ownerId],
        createdAt: DateTime.parse(json[NotesScheme.createdAt]),
      );

  NotesModel copyWith({
    String? id,
    bool? isCompleted,
    String? description,
    Color? color,
    String? ownerId,
    DateTime? createdAt,
  }) =>
      NotesModel(
        id: id ?? this.id,
        isCompleted: isCompleted ?? this.isCompleted,
        color: color ?? this.color,
        description: description ?? this.description,
        ownerId: ownerId ?? this.ownerId,
        createdAt: createdAt ?? this.createdAt,
      );
}
