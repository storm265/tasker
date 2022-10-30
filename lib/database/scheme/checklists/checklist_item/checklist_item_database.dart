import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:todo2/database/scheme/checklists/checklist_item/checklist_item_dao.dart';
import 'package:todo2/database/scheme/checklists/checklist_item/checklist_item_table.dart';

part 'checklist_item_database.g.dart';

@DriftDatabase(tables: [CheckListItemTable], daos: [CheckListItemDaoImpl])
class CheckListItemDatabase extends _$CheckListItemDatabase {
  CheckListItemDatabase() : super(_database());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _database() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory(); //internal
    final dbFile = File(join(dbFolder.path, "checklist_item.db"));
    return NativeDatabase(dbFile);
  });
}
