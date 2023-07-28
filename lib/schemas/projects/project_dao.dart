import 'package:drift/drift.dart';
import 'package:todo2/schemas/projects/project_table.dart';

import 'project_database.dart';

part 'project_dao.g.dart';

abstract class ProjectDao {
  Future<List<Project>> getProjects();

  Stream<List<Project>> getProjectsStream();

  Future<Project> getProject(String id);

  Future<bool> updateProject(ProjectTableCompanion entity);

  Future<int> insertProject(ProjectTableCompanion entity);

  Future<int> deleteProject(String id);

  Future<int> deleteAllProjects();
}

@DriftAccessor(tables: [ProjectTable])
class ProjectDaoImpl extends DatabaseAccessor<ProjectDatabase>
    with _$ProjectDaoImplMixin
    implements ProjectDao {
  ProjectDaoImpl(ProjectDatabase projectDatabase) : super(projectDatabase);

  @override
  Future<List<Project>> getProjects() => select(projectTable).get();

  @override
  Stream<List<Project>> getProjectsStream() => select(projectTable).watch();

  @override
  Future<Project> getProject(String id) =>
      (select(projectTable)..where((tbl) => tbl.id.equals(id))).getSingle();

  @override
  Future<bool> updateProject(ProjectTableCompanion entity) =>
      update(projectTable).replace(entity);

  @override
  Future<int> insertProject(ProjectTableCompanion entity) =>
      into(projectTable).insert(entity);

  @override
  Future<int> deleteProject(String id) =>
      (delete(projectTable)..where((tbl) => tbl.id.equals(id))).go();

  @override
  Future<int> deleteAllProjects() => (delete(projectTable)).go();
}
