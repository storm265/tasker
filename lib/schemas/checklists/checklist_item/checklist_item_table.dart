import 'package:drift/drift.dart';

class CheckListItemTable extends Table {
  TextColumn get id => text()();

  TextColumn get content => text()();

  @JsonKey('is_completed')
  BoolColumn get isCompleted => boolean()();

  @JsonKey('checklist_id')
  TextColumn get checklistId => text()();
  
  @JsonKey('created_at')
  TextColumn get createdAt => text()();

  @override
  Set<Column> get primaryKey => {id};
}
