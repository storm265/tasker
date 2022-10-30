// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checklist_item_database.dart';

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class CheckListItemTableData extends DataClass
    implements Insertable<CheckListItemTableData> {
  final String id;
  final String content;
  final bool isCompleted;
  final String? checklistId;
  final String createdAt;
  const CheckListItemTableData(
      {required this.id,
      required this.content,
      required this.isCompleted,
      this.checklistId,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['content'] = Variable<String>(content);
    map['is_completed'] = Variable<bool>(isCompleted);
    if (!nullToAbsent || checklistId != null) {
      map['checklist_id'] = Variable<String>(checklistId);
    }
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  CheckListItemTableCompanion toCompanion(bool nullToAbsent) {
    return CheckListItemTableCompanion(
      id: Value(id),
      content: Value(content),
      isCompleted: Value(isCompleted),
      checklistId: checklistId == null && nullToAbsent
          ? const Value.absent()
          : Value(checklistId),
      createdAt: Value(createdAt),
    );
  }

  factory CheckListItemTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CheckListItemTableData(
      id: serializer.fromJson<String>(json['id']),
      content: serializer.fromJson<String>(json['content']),
      isCompleted: serializer.fromJson<bool>(json['is_completed']),
      checklistId: serializer.fromJson<String?>(json['checklist_id']),
      createdAt: serializer.fromJson<String>(json['created_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'content': serializer.toJson<String>(content),
      'is_completed': serializer.toJson<bool>(isCompleted),
      'checklist_id': serializer.toJson<String?>(checklistId),
      'created_at': serializer.toJson<String>(createdAt),
    };
  }

  CheckListItemTableData copyWith(
          {String? id,
          String? content,
          bool? isCompleted,
          Value<String?> checklistId = const Value.absent(),
          String? createdAt}) =>
      CheckListItemTableData(
        id: id ?? this.id,
        content: content ?? this.content,
        isCompleted: isCompleted ?? this.isCompleted,
        checklistId: checklistId.present ? checklistId.value : this.checklistId,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('CheckListItemTableData(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('checklistId: $checklistId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, content, isCompleted, checklistId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CheckListItemTableData &&
          other.id == this.id &&
          other.content == this.content &&
          other.isCompleted == this.isCompleted &&
          other.checklistId == this.checklistId &&
          other.createdAt == this.createdAt);
}

class CheckListItemTableCompanion
    extends UpdateCompanion<CheckListItemTableData> {
  final Value<String> id;
  final Value<String> content;
  final Value<bool> isCompleted;
  final Value<String?> checklistId;
  final Value<String> createdAt;
  const CheckListItemTableCompanion({
    this.id = const Value.absent(),
    this.content = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.checklistId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CheckListItemTableCompanion.insert({
    required String id,
    required String content,
    required bool isCompleted,
    this.checklistId = const Value.absent(),
    required String createdAt,
  })  : id = Value(id),
        content = Value(content),
        isCompleted = Value(isCompleted),
        createdAt = Value(createdAt);
  static Insertable<CheckListItemTableData> custom({
    Expression<String>? id,
    Expression<String>? content,
    Expression<bool>? isCompleted,
    Expression<String>? checklistId,
    Expression<String>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (content != null) 'content': content,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (checklistId != null) 'checklist_id': checklistId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CheckListItemTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? content,
      Value<bool>? isCompleted,
      Value<String?>? checklistId,
      Value<String>? createdAt}) {
    return CheckListItemTableCompanion(
      id: id ?? this.id,
      content: content ?? this.content,
      isCompleted: isCompleted ?? this.isCompleted,
      checklistId: checklistId ?? this.checklistId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (checklistId.present) {
      map['checklist_id'] = Variable<String>(checklistId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CheckListItemTableCompanion(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('checklistId: $checklistId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CheckListItemTableTable extends CheckListItemTable
    with TableInfo<$CheckListItemTableTable, CheckListItemTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CheckListItemTableTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _contentMeta = const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _isCompletedMeta =
      const VerificationMeta('isCompleted');
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
      'is_completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK ("is_completed" IN (0, 1))');
  final VerificationMeta _checklistIdMeta =
      const VerificationMeta('checklistId');
  @override
  late final GeneratedColumn<String> checklistId = GeneratedColumn<String>(
      'checklist_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, content, isCompleted, checklistId, createdAt];
  @override
  String get aliasedName => _alias ?? 'check_list_item_table';
  @override
  String get actualTableName => 'check_list_item_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<CheckListItemTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('is_completed')) {
      context.handle(
          _isCompletedMeta,
          isCompleted.isAcceptableOrUnknown(
              data['is_completed']!, _isCompletedMeta));
    } else if (isInserting) {
      context.missing(_isCompletedMeta);
    }
    if (data.containsKey('checklist_id')) {
      context.handle(
          _checklistIdMeta,
          checklistId.isAcceptableOrUnknown(
              data['checklist_id']!, _checklistIdMeta));
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
  CheckListItemTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CheckListItemTableData(
      id: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      content: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      isCompleted: attachedDatabase.options.types
          .read(DriftSqlType.bool, data['${effectivePrefix}is_completed'])!,
      checklistId: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}checklist_id']),
      createdAt: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $CheckListItemTableTable createAlias(String alias) {
    return $CheckListItemTableTable(attachedDatabase, alias);
  }
}

abstract class _$CheckListItemDatabase extends GeneratedDatabase {
  _$CheckListItemDatabase(QueryExecutor e) : super(e);
  late final $CheckListItemTableTable checkListItemTable =
      $CheckListItemTableTable(this);
  late final CheckListItemDaoImpl checkListItemDaoImpl =
      CheckListItemDaoImpl(this as CheckListItemDatabase);
  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [checkListItemTable];
}
