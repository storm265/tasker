import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:todo2/database/scheme/tasks/task_dao.dart';
import 'package:todo2/database/scheme/tasks/task_table.dart';

part 'task_database.g.dart';

@DriftDatabase(tables: [TaskTable], daos: [TaskDaoImpl])
class TaskDatabase extends _$TaskDatabase {
 TaskDatabase() : super(_database());


  @override
  int get schemaVersion => 1;
}

LazyDatabase _database() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final dbFile = File(join(dbFolder.path, "task.db"));
    return NativeDatabase(dbFile);
  });
}
