import 'package:todo2/database/database_scheme/checklists_scheme.dart';

class CheckListModel {
  String ownerId;
  String title;
  String color;
  String createdAt;

  CheckListModel({
    required this.ownerId,
    required this.title,
    required this.color,
    required this.createdAt,
  });

  factory CheckListModel.fromJson(Map<String, dynamic> json) => CheckListModel(
        ownerId: json[CheckListsScheme.ownerId],
        title: json[CheckListsScheme.title],
        color: json[CheckListsScheme.color],
        createdAt: json[CheckListsScheme.createdAt],
      );
}
