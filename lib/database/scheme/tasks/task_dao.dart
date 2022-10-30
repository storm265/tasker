import 'package:drift/drift.dart';
import 'package:todo2/database/scheme/tasks/task_database.dart';
import 'package:todo2/database/scheme/tasks/task_table.dart';

part 'task_dao.g.dart';

@DriftAccessor(tables: [TaskTable])
class TaskDao extends DatabaseAccessor<TaskDatabase> with _$TaskDaoMixin {
  TaskDao(TaskDatabase taskDatabase) : super(taskDatabase);

  Future<List<Task>> getProjects() async {
    return await select(taskTable).get();
  }

  Stream<List<Task>> getProjectsStream() {
    return select(taskTable).watch();
  }

  Future<Task> getProject(String id) async {
    return await (select(taskTable)..where((tbl) => tbl.id.equals(id)))
        .getSingle();
  }

  Future<bool> updateProject(TaskTableCompanion entity) async {
    return await update(taskTable).replace(entity);
  }

  Future<int> insertProject(TaskTableCompanion entity) async {
    return await into(taskTable).insert(entity);
  }

  Future<int> deleteProject(String id) async {
    return await (delete(taskTable)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<int> deleteAllProjects() async {
    return await (delete(taskTable)).go();
  }
}
