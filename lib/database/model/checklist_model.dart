import 'package:flutter/material.dart';
import 'package:todo2/database/database_scheme/checklists_scheme.dart';
import 'package:todo2/utils/extensions/color_extension/color_string_extension.dart';

class CheckListModel {
  int id;
  String title;
  Color color;
  String createdAt;
  String ownerId;

  CheckListModel({
    required this.id,
    required this.title,
    required this.color,
    required this.createdAt,
    required this.ownerId,
  });

  factory CheckListModel.fromJson(Map<String, dynamic> json) => CheckListModel(
        id: json[CheckListsScheme.id],
        title: json[CheckListsScheme.title],
        color: Color(
          int.parse(
              json[CheckListsScheme.color].toString().replaceColorSymbol()),
        ),
        ownerId: json[CheckListsScheme.ownerId],
        createdAt: json[CheckListsScheme.createdAt],
      );
}
