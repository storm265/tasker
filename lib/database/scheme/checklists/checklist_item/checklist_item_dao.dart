import 'package:drift/drift.dart';
import 'package:todo2/database/scheme/checklists/checklist_item/checklist_item_database.dart';
import 'package:todo2/database/scheme/checklists/checklist_item/checklist_item_table.dart';
part 'checklist_item_dao.g.dart';

abstract class CheckListItemDao {
  Future<List<CheckListItemTableData>> getEmployees();

  Stream<List<CheckListItemTableData>> getEmployeesStream();

  Future<CheckListItemTableData> getEmployee(String id);

  Future<bool> updateEmployee(CheckListItemTableCompanion entity);

  Future<int> insertEmployee(CheckListItemTableCompanion entity);

  Future<int> deleteEmployee(String id);
}

@DriftAccessor(tables: [CheckListItemTable])
class CheckListItemDaoImpl extends DatabaseAccessor<CheckListItemDatabase>
    with _$CheckListItemDaoMixin
    implements CheckListItemDao {
  CheckListItemDaoImpl(CheckListItemDatabase checklistDatabase)
      : super(checklistDatabase);

  @override
  Future<List<CheckListItemTableData>> getEmployees() async {
    return await select(checkListItemTable).get();
  }

  @override
  Stream<List<CheckListItemTableData>> getEmployeesStream() {
    return select(checkListItemTable).watch();
  }

  @override
  Future<CheckListItemTableData> getEmployee(String id) async {
    return await (select(checkListItemTable)..where((tbl) => tbl.id.equals(id)))
        .getSingle();
  }

  @override
  Future<bool> updateEmployee(CheckListItemTableCompanion entity) async {
    return await update(checkListItemTable).replace(entity);
  }

  @override
  Future<int> insertEmployee(CheckListItemTableCompanion entity) async {
    return await into(checkListItemTable).insert(entity);
  }

  @override
  Future<int> deleteEmployee(String id) async {
    return await (delete(checkListItemTable)..where((tbl) => tbl.id.equals(id)))
        .go();
  }
}
