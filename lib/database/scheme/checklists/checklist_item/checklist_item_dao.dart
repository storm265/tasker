import 'package:drift/drift.dart';
import 'package:todo2/database/scheme/checklists/checklist_item/checklist_item_database.dart';
import 'package:todo2/database/scheme/checklists/checklist_item/checklist_item_table.dart';


part 'checklist_item_dao.g.dart';

@DriftAccessor(tables: [CheckListItemTable])
class CheckListItemDao extends DatabaseAccessor<CheckListItemDatabase>
    with _$CheckListItemDaoMixin {
  CheckListItemDao(CheckListItemDatabase checklistDatabase) : super(checklistDatabase);


  Future<List<CheckListItemTableData>> getEmployees() async {
    return await select(checkListItemTable).get();
  }

  Stream<List<CheckListItemTableData>> getEmployeesStream() {
    return select(checkListItemTable).watch();
  }

  Future<CheckListItemTableData> getEmployee(String id) async {
    return await (select(checkListItemTable)..where((tbl) => tbl.id.equals(id)))
        .getSingle();
  }

  Future<bool> updateEmployee(CheckListItemTableCompanion entity) async {
    return await update(checkListItemTable).replace(entity);
  }

  Future<int> insertEmployee(CheckListItemTableCompanion entity) async {
    return await into(checkListItemTable).insert(entity);
  }

  Future<int> deleteEmployee(String id) async {
    return await (delete(checkListItemTable)..where((tbl) => tbl.id.equals(id)))
        .go();
  }
}
