import 'package:todo2/database/database_scheme/check_list_items.dart';

class CheckListItemModel {
  final String? content, ownerId;
  final int checklistId;
  final bool isCompleted;
  CheckListItemModel({
    required this.checklistId,
    required this.content,
    required this.isCompleted,
    required this.ownerId,
  });
  factory CheckListItemModel.fromJson(Map<String, dynamic> json) =>
      CheckListItemModel(
        content: json[CheckListItemsScheme.content],
        isCompleted: json[CheckListItemsScheme.isCompleted],
        ownerId: json[CheckListItemsScheme.ownerId],
        checklistId: json[CheckListItemsScheme.checklistId],
      );
}
