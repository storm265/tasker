import 'package:drift/drift.dart';

@DataClassName("Note")
class NoteTable extends Table {
  TextColumn get id => text()();
  BoolColumn get isCompleted => boolean()();
  TextColumn get description => text()();
  IntColumn get color => integer()();
  TextColumn get ownerId => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
