import 'package:todo2/database/database_scheme/check_list_items_scheme.dart';

class CheckListItemModel {
  final String? id;
  final String content;
  final bool isCompleted;
  final String? checklistId;
  final DateTime? createdAt;
  CheckListItemModel({
    this.checklistId,
    required this.content,
    required this.isCompleted,
    this.id,
    this.createdAt,
  });

  factory CheckListItemModel.fromJson(Map<String, dynamic> json) =>
      CheckListItemModel(
        content: json[CheckListItemsScheme.content],
        isCompleted: json[CheckListItemsScheme.isCompleted],
        id: json[CheckListItemsScheme.id],
        checklistId: json[CheckListItemsScheme.checklistId],
        createdAt: DateTime.parse(json[CheckListItemsScheme.createdAt]),
      );

  CheckListItemModel copyWith({
    String? id,
    String? content,
    bool? isCompleted,
    String? checklistId,
    DateTime? createdAt,
  }) =>
      CheckListItemModel(
        id: id ?? this.id,
        content: content ?? this.content,
        isCompleted: isCompleted ?? this.isCompleted,
        checklistId: checklistId,
        createdAt: createdAt,
      );
}
