import 'package:drift/drift.dart';
import 'package:todo2/database/scheme/checklists/checklist/checklist_database.dart';
import 'package:todo2/database/scheme/checklists/checklist/checklist_table.dart';

part 'checklist_dao.g.dart';

@DriftAccessor(tables: [CheckListTable])
class CheckListDao extends DatabaseAccessor<CheckListDatabase>
    with _$CheckListDaoMixin {
  CheckListDao(CheckListDatabase checklistDatabase) : super(checklistDatabase);

  Future<List<Checklist>> getChecklists() async {
    return await select(checkListTable).get();
  }

  Stream<List<Checklist>> getChecklistsStream() {
    return select(checkListTable).watch();
  }

  Future<Checklist> getChecklist(String id) async {
    return await (select(checkListTable)..where((tbl) => tbl.id.equals(id)))
        .getSingle();
  }

  Future<bool> updateChecklist(CheckListTableCompanion entity) async {
    return await update(checkListTable).replace(entity);
  }

  Future<int> insertChecklist(CheckListTableCompanion entity) async {
    return await into(checkListTable).insert(entity);
  }

  Future<int> deleteChecklist(String id) async {
    return await (delete(checkListTable)..where((tbl) => tbl.id.equals(id)))
        .go();
  }
}
