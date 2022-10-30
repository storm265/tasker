import 'package:drift/drift.dart';
import 'package:todo2/database/scheme/checklists/checklist_item/checklist_item_database.dart';
import 'package:todo2/database/scheme/checklists/checklist_item/checklist_item_table.dart';
part 'checklist_item_dao.g.dart';

abstract class CheckListItemDao {
  Future<List<CheckListItemTableData>> getChecklistItems();

  Stream<List<CheckListItemTableData>> getChecklistItemsStream();

  Future<CheckListItemTableData> getChecklistItem(String id);

  Future<bool> updateChecklistItem(CheckListItemTableCompanion entity);

  Future<int> insertChecklistItem(CheckListItemTableCompanion entity);

  Future<int> deleteChecklist(String id);

  Future<int> deleteAllChecklistItems();
}

@DriftAccessor(tables: [CheckListItemTable])
class CheckListItemDaoImpl extends DatabaseAccessor<CheckListItemDatabase>
    with _$CheckListItemDaoImplMixin
    implements CheckListItemDao {
  CheckListItemDaoImpl(CheckListItemDatabase checklistDatabase)
      : super(checklistDatabase);

  @override
  Future<List<CheckListItemTableData>> getChecklistItems() async {
    return await select(checkListItemTable).get();
  }

  @override
  Stream<List<CheckListItemTableData>> getChecklistItemsStream() {
    return select(checkListItemTable).watch();
  }

  @override
  Future<CheckListItemTableData> getChecklistItem(String id) async {
    return await (select(checkListItemTable)..where((tbl) => tbl.id.equals(id)))
        .getSingle();
  }

  @override
  Future<bool> updateChecklistItem(CheckListItemTableCompanion entity) async {
    return await update(checkListItemTable).replace(entity);
  }

  @override
  Future<int> insertChecklistItem(CheckListItemTableCompanion entity) async {
    return await into(checkListItemTable).insert(entity);
  }

  @override
  Future<int> deleteChecklist(String id) async {
    return await (delete(checkListItemTable)..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  @override
  Future<int> deleteAllChecklistItems() async {
    return await (delete(checkListItemTable)).go();
  }
}
