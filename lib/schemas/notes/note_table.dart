import 'package:drift/drift.dart';

@DataClassName("Note")
class NoteTable extends Table {
  TextColumn get id => text()();
  @JsonKey('is_completed')
  BoolColumn get isCompleted => boolean()();
  TextColumn get description => text()();
  TextColumn get color => text()();
  @JsonKey('owner_id')
  TextColumn get ownerId => text()();
  @JsonKey('created_at')
  TextColumn get createdAt => text()();

  @override
  Set<Column> get primaryKey => {id};
}
