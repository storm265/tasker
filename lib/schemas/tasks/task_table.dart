import 'package:drift/drift.dart';

@DataClassName("Task")
class TaskTable extends Table {
  TextColumn get id => text()();

  TextColumn get title => text()();

  @JsonKey('due_date')
  TextColumn get dueDate => text()();

  TextColumn get description => text()();

  @JsonKey('assigned_to')
  TextColumn get assignedTo => text().nullable()();

  @JsonKey('is_completed')
  BoolColumn get isCompleted => boolean()();

  @JsonKey('project_id')
  TextColumn get projectId => text()();

  @JsonKey('owner_id')
  TextColumn get ownerId => text()();

  @JsonKey('created_at')
  TextColumn get createdAt => text()();

  @override
  Set<Column> get primaryKey => {id};
}
