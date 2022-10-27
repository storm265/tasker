// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_database.dart';

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Project extends DataClass implements Insertable<Project> {
  final String id;
  final String title;
  final int color;
  final String ownerId;
  final DateTime createdAt;
  const Project(
      {required this.id,
      required this.title,
      required this.color,
      required this.ownerId,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['color'] = Variable<int>(color);
    map['owner_id'] = Variable<String>(ownerId);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ProjectTableCompanion toCompanion(bool nullToAbsent) {
    return ProjectTableCompanion(
      id: Value(id),
      title: Value(title),
      color: Value(color),
      ownerId: Value(ownerId),
      createdAt: Value(createdAt),
    );
  }

  factory Project.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Project(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      color: serializer.fromJson<int>(json['color']),
      ownerId: serializer.fromJson<String>(json['ownerId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'color': serializer.toJson<int>(color),
      'ownerId': serializer.toJson<String>(ownerId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Project copyWith(
          {String? id,
          String? title,
          int? color,
          String? ownerId,
          DateTime? createdAt}) =>
      Project(
        id: id ?? this.id,
        title: title ?? this.title,
        color: color ?? this.color,
        ownerId: ownerId ?? this.ownerId,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('Project(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('color: $color, ')
          ..write('ownerId: $ownerId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, color, ownerId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Project &&
          other.id == this.id &&
          other.title == this.title &&
          other.color == this.color &&
          other.ownerId == this.ownerId &&
          other.createdAt == this.createdAt);
}

class ProjectTableCompanion extends UpdateCompanion<Project> {
  final Value<String> id;
  final Value<String> title;
  final Value<int> color;
  final Value<String> ownerId;
  final Value<DateTime> createdAt;
  const ProjectTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.color = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ProjectTableCompanion.insert({
    required String id,
    required String title,
    required int color,
    required String ownerId,
    required DateTime createdAt,
  })  : id = Value(id),
        title = Value(title),
        color = Value(color),
        ownerId = Value(ownerId),
        createdAt = Value(createdAt);
  static Insertable<Project> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<int>? color,
    Expression<String>? ownerId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (color != null) 'color': color,
      if (ownerId != null) 'owner_id': ownerId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ProjectTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<int>? color,
      Value<String>? ownerId,
      Value<DateTime>? createdAt}) {
    return ProjectTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      color: color ?? this.color,
      ownerId: ownerId ?? this.ownerId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<String>(ownerId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProjectTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('color: $color, ')
          ..write('ownerId: $ownerId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ProjectTableTable extends ProjectTable
    with TableInfo<$ProjectTableTable, Project> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProjectTableTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
      'color', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _ownerIdMeta = const VerificationMeta('ownerId');
  @override
  late final GeneratedColumn<String> ownerId = GeneratedColumn<String>(
      'owner_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, title, color, ownerId, createdAt];
  @override
  String get aliasedName => _alias ?? 'project_table';
  @override
  String get actualTableName => 'project_table';
  @override
  VerificationContext validateIntegrity(Insertable<Project> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    if (data.containsKey('owner_id')) {
      context.handle(_ownerIdMeta,
          ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta));
    } else if (isInserting) {
      context.missing(_ownerIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Project map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Project(
      id: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      color: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}color'])!,
      ownerId: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}owner_id'])!,
      createdAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $ProjectTableTable createAlias(String alias) {
    return $ProjectTableTable(attachedDatabase, alias);
  }
}

abstract class _$ProjectDatabase extends GeneratedDatabase {
  _$ProjectDatabase(QueryExecutor e) : super(e);
  late final $ProjectTableTable projectTable = $ProjectTableTable(this);
  late final ProjectDao projectDao = ProjectDao(this as ProjectDatabase);
  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [projectTable];
}
