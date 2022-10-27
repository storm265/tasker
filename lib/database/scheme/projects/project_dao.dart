import 'package:drift/drift.dart';
import 'package:todo2/database/scheme/projects/project_database.dart';
import 'package:todo2/database/scheme/projects/project_table.dart';

part 'project_dao.g.dart';

@DriftAccessor(tables: [ProjectTable])
class ProjectDao extends DatabaseAccessor<ProjectDatabase>
    with _$ProjectDaoMixin {
  ProjectDao(ProjectDatabase projectDatabase) : super(projectDatabase);

  Future<List<Project>> getChecklists() async {
    return await select(projectTable).get();
  }

  Stream<List<Project>> getChecklistsStream() {
    return select(projectTable).watch();
  }

  Future<Project> getChecklist(String id) async {
    return await (select(projectTable)..where((tbl) => tbl.id.equals(id)))
        .getSingle();
  }

  Future<bool> updateChecklist(ProjectTableCompanion entity) async {
    return await update(projectTable).replace(entity);
  }

  Future<int> insertChecklist(ProjectTableCompanion entity) async {
    return await into(projectTable).insert(entity);
  }

  Future<int> deleteChecklist(String id) async {
    return await (delete(projectTable)..where((tbl) => tbl.id.equals(id))).go();
  }
}
