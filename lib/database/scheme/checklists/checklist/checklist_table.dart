import 'package:drift/drift.dart';

@DataClassName("Checklist")
class CheckListTable extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get color => text()();
  @JsonKey('owner_id')
  TextColumn get ownerId => text()();
  @JsonKey('created_at')
  TextColumn get createdAt => text()();

  @override
  Set<Column> get primaryKey => {id};
}
