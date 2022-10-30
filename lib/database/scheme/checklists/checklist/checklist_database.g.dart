// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checklist_database.dart';

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Checklist extends DataClass implements Insertable<Checklist> {
  final String id;
  final String title;
  final String color;
  final String ownerId;
  final String createdAt;
  const Checklist(
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
    map['color'] = Variable<String>(color);
    map['owner_id'] = Variable<String>(ownerId);
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  CheckListTableCompanion toCompanion(bool nullToAbsent) {
    return CheckListTableCompanion(
      id: Value(id),
      title: Value(title),
      color: Value(color),
      ownerId: Value(ownerId),
      createdAt: Value(createdAt),
    );
  }

  factory Checklist.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Checklist(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      color: serializer.fromJson<String>(json['color']),
      ownerId: serializer.fromJson<String>(json['owner_id']),
      createdAt: serializer.fromJson<String>(json['created_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'color': serializer.toJson<String>(color),
      'owner_id': serializer.toJson<String>(ownerId),
      'created_at': serializer.toJson<String>(createdAt),
    };
  }

  Checklist copyWith(
          {String? id,
          String? title,
          String? color,
          String? ownerId,
          String? createdAt}) =>
      Checklist(
        id: id ?? this.id,
        title: title ?? this.title,
        color: color ?? this.color,
        ownerId: ownerId ?? this.ownerId,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('Checklist(')
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
      (other is Checklist &&
          other.id == this.id &&
          other.title == this.title &&
          other.color == this.color &&
          other.ownerId == this.ownerId &&
          other.createdAt == this.createdAt);
}

class CheckListTableCompanion extends UpdateCompanion<Checklist> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> color;
  final Value<String> ownerId;
  final Value<String> createdAt;
  const CheckListTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.color = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CheckListTableCompanion.insert({
    required String id,
    required String title,
    required String color,
    required String ownerId,
    required String createdAt,
  })  : id = Value(id),
        title = Value(title),
        color = Value(color),
        ownerId = Value(ownerId),
        createdAt = Value(createdAt);
  static Insertable<Checklist> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? color,
    Expression<String>? ownerId,
    Expression<String>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (color != null) 'color': color,
      if (ownerId != null) 'owner_id': ownerId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CheckListTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String>? color,
      Value<String>? ownerId,
      Value<String>? createdAt}) {
    return CheckListTableCompanion(
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
      map['color'] = Variable<String>(color.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<String>(ownerId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CheckListTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('color: $color, ')
          ..write('ownerId: $ownerId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CheckListTableTable extends CheckListTable
    with TableInfo<$CheckListTableTable, Checklist> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CheckListTableTable(this.attachedDatabase, [this._alias]);
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
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
      'color', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _ownerIdMeta = const VerificationMeta('ownerId');
  @override
  late final GeneratedColumn<String> ownerId = GeneratedColumn<String>(
      'owner_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, title, color, ownerId, createdAt];
  @override
  String get aliasedName => _alias ?? 'check_list_table';
  @override
  String get actualTableName => 'check_list_table';
  @override
  VerificationContext validateIntegrity(Insertable<Checklist> instance,
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
  Checklist map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Checklist(
      id: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      color: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}color'])!,
      ownerId: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}owner_id'])!,
      createdAt: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $CheckListTableTable createAlias(String alias) {
    return $CheckListTableTable(attachedDatabase, alias);
  }
}

abstract class _$CheckListDatabase extends GeneratedDatabase {
  _$CheckListDatabase(QueryExecutor e) : super(e);
  late final $CheckListTableTable checkListTable = $CheckListTableTable(this);
  late final CheckListDaoImpl checkListDaoImpl =
      CheckListDaoImpl(this as CheckListDatabase);
  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [checkListTable];
}
