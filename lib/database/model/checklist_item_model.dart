import 'package:todo2/database/database_scheme/check_list_items.dart';

class CheckListItemModel {
  String content;
  String? uuid;
  String? createdAt;
  int checklistId;
  bool isCompleted;
  CheckListItemModel({
    required this.checklistId,
    required this.content,
    required this.isCompleted,
    required this.uuid,
    required this.createdAt,
  });
  factory CheckListItemModel.fromJson(Map<String, dynamic> json) =>
      CheckListItemModel(
        content: json[CheckListItemsScheme.content],
        isCompleted: json[CheckListItemsScheme.isCompleted],
        uuid: json[CheckListItemsScheme.uuid] ?? 'null',
        checklistId: json[CheckListItemsScheme.checklistId],
        createdAt: json[CheckListItemsScheme.createdAt]?? 'null',
      );
}
