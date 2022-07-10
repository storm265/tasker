import 'package:todo2/database/database_scheme/checklists_scheme.dart';

class CheckListModel {
  int id;
  String title;
  String color;
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
        color: json[CheckListsScheme.color],
        createdAt: json[CheckListsScheme.createdAt],
        ownerId: json[CheckListsScheme.ownerId],
      );
}
