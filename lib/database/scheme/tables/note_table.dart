import 'package:drift/drift.dart';

part 'note_table.g.dart';

class NoteTable extends Table {
  TextColumn get id => text()();
  BoolColumn get isCompleted => boolean()();
  TextColumn get description => text()();
  TextColumn get color => text()();
  TextColumn get ownerId => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
