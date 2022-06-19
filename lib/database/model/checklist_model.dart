class CheckListModel {
  int? checklistId;
  String? title, color, ownerId;
  CheckListModel({this.checklistId, this.title, this.color, this.ownerId});

  factory CheckListModel.fromJson(Map<String, dynamic> json) => CheckListModel(
        checklistId: json['checklist_id'],
        title: json['title'],
        color: json['color'],
        ownerId: json['owner_id'],
      );
}
