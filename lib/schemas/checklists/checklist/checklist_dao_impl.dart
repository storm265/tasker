import 'package:drift/drift.dart';
import 'package:todo2/schemas/checklists/checklist/checklist_database.dart';
import 'package:todo2/schemas/checklists/checklist/checklist_table.dart';

part 'checklist_dao.g.dart';

abstract class CheckListDao {
  Future<List<Checklist>> getChecklists();

  Stream<List<Checklist>> getChecklistsStream();

  Future<Checklist> getChecklist(String id);

  Future<bool> updateChecklist(CheckListTableCompanion entity);

  Future<int> insertChecklist(CheckListTableCompanion entity);

  Future<int> deleteChecklist(String id);

  Future<int> deleteAllChecklists();
}

@DriftAccessor(tables: [CheckListTable])
class CheckListDaoImpl extends DatabaseAccessor<CheckListDatabase>
    with _$CheckListDaoImplMixin
    implements CheckListDao {
  CheckListDaoImpl(CheckListDatabase checklistDatabase)
      : super(checklistDatabase);

  @override
  Future<List<Checklist>> getChecklists() => select(checkListTable).get();

  @override
  Stream<List<Checklist>> getChecklistsStream() =>
      select(checkListTable).watch();

  @override
  Future<Checklist> getChecklist(String id) =>
      (select(checkListTable)..where((tbl) => tbl.id.equals(id))).getSingle();

  @override
  Future<bool> updateChecklist(CheckListTableCompanion entity) =>
      update(checkListTable).replace(entity);

  @override
  Future<int> insertChecklist(CheckListTableCompanion entity) =>
      into(checkListTable).insert(entity);

  @override
  Future<int> deleteChecklist(String id) =>
      (delete(checkListTable)..where((tbl) => tbl.id.equals(id))).go();

  @override
  Future<int> deleteAllChecklists() => (delete(checkListTable)).go();
}
