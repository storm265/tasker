import 'package:todo2/database/database_scheme/checklists_scheme.dart';

class CheckListModel {
  int? checklistId;
  String? title, color, ownerId;

  CheckListModel({
    this.checklistId,
    this.title,
    this.color,
    this.ownerId,
  });

  factory CheckListModel.fromJson(Map<String, dynamic> json) => CheckListModel(
        title: json[CheckListsScheme.title],
        color: json[CheckListsScheme.color],
        ownerId: json[CheckListsScheme.ownerId],
      );
}
