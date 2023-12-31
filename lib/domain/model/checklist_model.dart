import 'package:flutter/material.dart';
import 'package:todo2/domain/model/checklist_item_model.dart';
import 'package:todo2/schemas/database_scheme/checklists_scheme.dart';
import 'package:todo2/utils/extensions/color_extension/color_string_extension.dart';

class CheckListModel {
  final String id;
  final String title;
  final Color color;
  final DateTime createdAt;
  final String ownerId;
  final List<CheckListItemModel> items;

  CheckListModel({
    required this.id,
    required this.title,
    required this.color,
    required this.ownerId,
    required this.createdAt,
    required this.items,
  });

  factory CheckListModel.fromJson(Map<String, dynamic> json) {
    return CheckListModel(
      id: json[CheckListsScheme.id],
      title: json[CheckListsScheme.title],
      color: Color(
        int.parse(json[CheckListsScheme.color].toString().replaceColorSymbol()),
      ),
      ownerId: json[CheckListsScheme.ownerId],
      createdAt: DateTime.parse(json[CheckListsScheme.createdAt]),
      items: (json[CheckListsScheme.items] as List<dynamic>)
          .map((e) => CheckListItemModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      CheckListsScheme.id: id,
      CheckListsScheme.title: title,
      CheckListsScheme.color: color,
      CheckListsScheme.createdAt: createdAt,
      CheckListsScheme.items: items,
    };
  }

  CheckListModel copyWith({
    String? id,
    String? title,
    Color? color,
    DateTime? createdAt,
    String? ownerId,
    List<CheckListItemModel>? items,
  }) =>
      CheckListModel(
        id: id ?? this.id,
        title: title ?? this.title,
        color: color ?? this.color,
        items: items ?? this.items,
        ownerId: ownerId ?? this.ownerId,
        createdAt: createdAt ?? this.createdAt,
      );
}
