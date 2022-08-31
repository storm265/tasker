import 'package:todo2/database/database_scheme/check_list_items_scheme.dart';

class CheckListItemModel {
  final String id;
  final String content;
  final bool isCompleted;

  final String checklistId;
  final String createdAt;
  CheckListItemModel({
    required this.checklistId,
    required this.content,
    required this.isCompleted,
    required this.id,
    required this.createdAt,
  });
  factory CheckListItemModel.fromJson(Map<String, dynamic> json) =>
      CheckListItemModel(
        content: json[CheckListItemsScheme.content],
        isCompleted: json[CheckListItemsScheme.isCompleted],
        id: json[CheckListItemsScheme.id],
        checklistId: json[CheckListItemsScheme.checklistId],
        createdAt: json[CheckListItemsScheme.createdAt],
      );
}
