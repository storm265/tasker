// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_database.dart';

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Note extends DataClass implements Insertable<Note> {
  final String id;
  final bool isCompleted;
  final String description;
  final String color;
  final String ownerId;
  final String createdAt;
  const Note(
      {required this.id,
      required this.isCompleted,
      required this.description,
      required this.color,
      required this.ownerId,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['is_completed'] = Variable<bool>(isCompleted);
    map['description'] = Variable<String>(description);
    map['color'] = Variable<String>(color);
    map['owner_id'] = Variable<String>(ownerId);
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  NoteTableCompanion toCompanion(bool nullToAbsent) {
    return NoteTableCompanion(
      id: Value(id),
      isCompleted: Value(isCompleted),
      description: Value(description),
      color: Value(color),
      ownerId: Value(ownerId),
      createdAt: Value(createdAt),
    );
  }

  factory Note.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Note(
      id: serializer.fromJson<String>(json['id']),
      isCompleted: serializer.fromJson<bool>(json['is_completed']),
      description: serializer.fromJson<String>(json['description']),
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
      'is_completed': serializer.toJson<bool>(isCompleted),
      'description': serializer.toJson<String>(description),
      'color': serializer.toJson<String>(color),
      'owner_id': serializer.toJson<String>(ownerId),
      'created_at': serializer.toJson<String>(createdAt),
    };
  }

  Note copyWith(
          {String? id,
          bool? isCompleted,
          String? description,
          String? color,
          String? ownerId,
          String? createdAt}) =>
      Note(
        id: id ?? this.id,
        isCompleted: isCompleted ?? this.isCompleted,
        description: description ?? this.description,
        color: color ?? this.color,
        ownerId: ownerId ?? this.ownerId,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('Note(')
          ..write('id: $id, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('description: $description, ')
          ..write('color: $color, ')
          ..write('ownerId: $ownerId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, isCompleted, description, color, ownerId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Note &&
          other.id == this.id &&
          other.isCompleted == this.isCompleted &&
          other.description == this.description &&
          other.color == this.color &&
          other.ownerId == this.ownerId &&
          other.createdAt == this.createdAt);
}

class NoteTableCompanion extends UpdateCompanion<Note> {
  final Value<String> id;
  final Value<bool> isCompleted;
  final Value<String> description;
  final Value<String> color;
  final Value<String> ownerId;
  final Value<String> createdAt;
  const NoteTableCompanion({
    this.id = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.description = const Value.absent(),
    this.color = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  NoteTableCompanion.insert({
    required String id,
    required bool isCompleted,
    required String description,
    required String color,
    required String ownerId,
    required String createdAt,
  })  : id = Value(id),
        isCompleted = Value(isCompleted),
        description = Value(description),
        color = Value(color),
        ownerId = Value(ownerId),
        createdAt = Value(createdAt);
  static Insertable<Note> custom({
    Expression<String>? id,
    Expression<bool>? isCompleted,
    Expression<String>? description,
    Expression<String>? color,
    Expression<String>? ownerId,
    Expression<String>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (description != null) 'description': description,
      if (color != null) 'color': color,
      if (ownerId != null) 'owner_id': ownerId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  NoteTableCompanion copyWith(
      {Value<String>? id,
      Value<bool>? isCompleted,
      Value<String>? description,
      Value<String>? color,
      Value<String>? ownerId,
      Value<String>? createdAt}) {
    return NoteTableCompanion(
      id: id ?? this.id,
      isCompleted: isCompleted ?? this.isCompleted,
      description: description ?? this.description,
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
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
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
    return (StringBuffer('NoteTableCompanion(')
          ..write('id: $id, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('description: $description, ')
          ..write('color: $color, ')
          ..write('ownerId: $ownerId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $NoteTableTable extends NoteTable with TableInfo<$NoteTableTable, Note> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NoteTableTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _isCompletedMeta =
      const VerificationMeta('isCompleted');
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
      'is_completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK ("is_completed" IN (0, 1))');
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
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
  List<GeneratedColumn> get $columns =>
      [id, isCompleted, description, color, ownerId, createdAt];
  @override
  String get aliasedName => _alias ?? 'note_table';
  @override
  String get actualTableName => 'note_table';
  @override
  VerificationContext validateIntegrity(Insertable<Note> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('is_completed')) {
      context.handle(
          _isCompletedMeta,
          isCompleted.isAcceptableOrUnknown(
              data['is_completed']!, _isCompletedMeta));
    } else if (isInserting) {
      context.missing(_isCompletedMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
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
  Note map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Note(
      id: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      isCompleted: attachedDatabase.options.types
          .read(DriftSqlType.bool, data['${effectivePrefix}is_completed'])!,
      description: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      color: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}color'])!,
      ownerId: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}owner_id'])!,
      createdAt: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $NoteTableTable createAlias(String alias) {
    return $NoteTableTable(attachedDatabase, alias);
  }
}

abstract class _$NoteDatabase extends GeneratedDatabase {
  _$NoteDatabase(QueryExecutor e) : super(e);
  late final $NoteTableTable noteTable = $NoteTableTable(this);
  late final NoteDaoImpl noteDaoImpl = NoteDaoImpl(this as NoteDatabase);
  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [noteTable];
}
