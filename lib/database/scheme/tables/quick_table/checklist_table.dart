import 'dart:io';

import 'package:drift/drift.dart';
// These imports are only needed to open the database
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'checklist_table.g.dart';

class CheckListTable extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get color => text()();
  TextColumn get ownerId => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

// This annotation tells the code generator which tables this DB works with
@DriftDatabase(tables: [CheckListTable])
// _$AppDatabase is the name of the generated class
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      // Specify the location of the database file
      : super(_openConnection());

  // Bump this when changing tables and columns.
  // Migrations will be covered in the next part.

  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'checklist.sqlite'));
    return NativeDatabase(file);
  });
}
