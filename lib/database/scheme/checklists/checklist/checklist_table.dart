import 'package:drift/drift.dart';

@DataClassName("Checklist")
class CheckListTable extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  IntColumn get color => integer()();
  TextColumn get ownerId => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}