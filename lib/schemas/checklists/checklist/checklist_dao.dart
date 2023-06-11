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
  Future<List<Checklist>> getChecklists() async {
    return await select(checkListTable).get();
  }

  @override
  Stream<List<Checklist>> getChecklistsStream() {
    return select(checkListTable).watch();
  }

  @override
  Future<Checklist> getChecklist(String id) async {
    return await (select(checkListTable)..where((tbl) => tbl.id.equals(id)))
        .getSingle();
  }

  @override
  Future<bool> updateChecklist(CheckListTableCompanion entity) async {
    return await update(checkListTable).replace(entity);
  }

  @override
  Future<int> insertChecklist(CheckListTableCompanion entity) async {
    return await into(checkListTable).insert(entity);
  }

  @override
  Future<int> deleteChecklist(String id) async {
    return await (delete(checkListTable)..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  @override
  Future<int> deleteAllChecklists() async {
    return await (delete(checkListTable)).go();
  }
}
