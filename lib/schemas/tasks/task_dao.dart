import 'package:drift/drift.dart';

import 'task_database.dart';
import 'task_table.dart';

part 'task_dao.g.dart';

abstract class TaskDao {
  Future<List<Task>> getTasks();

  Stream<List<Task>> getTasksStream();

  Future<Task> getTask(String id);

  Future<bool> updateTask(TaskTableCompanion entity);

  Future<int> insertTask(TaskTableCompanion entity);

  Future<int> deleteTask(String id);

  Future<int> deleteAllTasks();
}

@DriftAccessor(tables: [TaskTable])
class TaskDaoImpl extends DatabaseAccessor<TaskDatabase>
    with _$TaskDaoImplMixin
    implements TaskDao {
  TaskDaoImpl(TaskDatabase taskDatabase) : super(taskDatabase);

  @override
  Future<List<Task>> getTasks() => select(taskTable).get();

  @override
  Stream<List<Task>> getTasksStream() => select(taskTable).watch();

  @override
  Future<Task> getTask(String id) =>
      (select(taskTable)..where((tbl) => tbl.id.equals(id))).getSingle();

  @override
  Future<bool> updateTask(TaskTableCompanion entity) =>
      update(taskTable).replace(entity);

  @override
  Future<int> insertTask(TaskTableCompanion entity) =>
      into(taskTable).insert(entity, mode: InsertMode.insertOrReplace);

  @override
  Future<int> deleteTask(String id) =>
      (delete(taskTable)..where((tbl) => tbl.id.equals(id))).go();

  @override
  Future<int> deleteAllTasks() => (delete(taskTable)).go();
}
