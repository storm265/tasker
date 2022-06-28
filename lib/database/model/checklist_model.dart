import 'package:todo2/database/database_scheme/checklists_scheme.dart';

class CheckListModel {
  String title;
  String color;
  String? uuid;
  String? createdAt;

  CheckListModel({
    required this.title,
    required this.color,
    required this.uuid,
    required this.createdAt,
  });

  factory CheckListModel.fromJson(Map<String, dynamic> json) => CheckListModel(
        title: json[CheckListsScheme.title],
        color: json[CheckListsScheme.color],
        uuid: json[CheckListsScheme.uuid] ?? 'null',
        createdAt: json[CheckListsScheme.createdAt] ?? 'null',
      );
}
