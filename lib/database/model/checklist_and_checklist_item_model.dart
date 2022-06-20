class CheckListItemAndCheckListModel {
  int? checklistId;
  String? title, color, ownerId, content;
  bool? isCompleted;

  CheckListItemAndCheckListModel({
     this.checklistId,
     this.title,
     this.color,
     this.ownerId,
     this.content,
     this.isCompleted,
  });

  factory CheckListItemAndCheckListModel.fromJson(Map<String, dynamic> json) =>
      CheckListItemAndCheckListModel(
        checklistId: json['checklistId'],
        title: json['title'],
        color: json['color'],
        ownerId: json['ownerId'],
        content: json['content'],
        isCompleted: json['isCompleted'],
      );
}
