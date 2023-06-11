import 'package:drift/drift.dart';
import 'package:todo2/database/schemas/projects/project_table.dart';
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
  Future<List<Project>> getProjects() async {
    return await select(projectTable).get();
  }

  @override
  Stream<List<Project>> getProjectsStream() {
    return select(projectTable).watch();
  }

  @override
  Future<Project> getProject(String id) async {
    return await (select(projectTable)..where((tbl) => tbl.id.equals(id)))
        .getSingle();
  }

  @override
  Future<bool> updateProject(ProjectTableCompanion entity) async {
    return await update(projectTable).replace(entity);
  }

  @override
  Future<int> insertProject(ProjectTableCompanion entity) async {
    return await into(projectTable).insert(entity);
  }

  @override
  Future<int> deleteProject(String id) async {
    return await (delete(projectTable)..where((tbl) => tbl.id.equals(id))).go();
  }

  @override
  Future<int> deleteAllProjects() async {
    return await (delete(projectTable)).go();
  }
}
