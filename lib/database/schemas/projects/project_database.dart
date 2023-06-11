import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:todo2/database/schemas/projects/project_dao.dart';
import 'package:todo2/database/schemas/projects/project_table.dart';
part 'project_database.g.dart';

@DriftDatabase(tables: [ProjectTable], daos: [ProjectDaoImpl])
class ProjectDatabase extends _$ProjectDatabase {
  ProjectDatabase() : super(_database());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _database() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final dbFile = File(join(dbFolder.path, "project.db"));
    return NativeDatabase(dbFile);
  });
}
