import 'package:drift/drift.dart';
import 'package:todo2/database/scheme/tasks/task_database.dart';
import 'package:todo2/database/scheme/tasks/task_table.dart';

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
  Future<List<Task>> getTasks() async {
    return await select(taskTable).get();
  }

  @override
  Stream<List<Task>> getTasksStream() {
    return select(taskTable).watch();
  }

  @override
  Future<Task> getTask(String id) async {
    return await (select(taskTable)..where((tbl) => tbl.id.equals(id)))
        .getSingle();
  }

  @override
  Future<bool> updateTask(TaskTableCompanion entity) async {
    return await update(taskTable).replace(entity);
  }

  @override
  Future<int> insertTask(TaskTableCompanion entity) async {
    return await into(taskTable).insert(entity);
  }

  @override
  Future<int> deleteTask(String id) async {
    return await (delete(taskTable)..where((tbl) => tbl.id.equals(id))).go();
  }

  @override
  Future<int> deleteAllTasks() async {
    return await (delete(taskTable)).go();
  }
}
