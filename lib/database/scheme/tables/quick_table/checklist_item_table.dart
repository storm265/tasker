import 'package:drift/drift.dart';

part 'checklist_item_table.g.dart';

@DataClassName("CheckListItem")
class CheckListItemTable extends Table {
  TextColumn get id => text()();
  TextColumn get content => text()();
  BoolColumn get isCompleted => boolean()();
  TextColumn get checklistId => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
