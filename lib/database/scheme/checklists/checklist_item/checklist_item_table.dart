import 'package:drift/drift.dart';

class CheckListItemTable extends Table {
  TextColumn get id => text()();
  TextColumn get content => text()();
  BoolColumn get isCompleted => boolean()();
  TextColumn get checklistId => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}