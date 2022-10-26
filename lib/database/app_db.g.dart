// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_db.dart';

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class NoteTableData extends DataClass implements Insertable<NoteTableData> {
  final String id;
  final bool isCompleted;
  final String description;
  final String color;
  final String ownerId;
  final DateTime createdAt;
  const NoteTableData(
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
    map['created_at'] = Variable<DateTime>(createdAt);
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

  factory NoteTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NoteTableData(
      id: serializer.fromJson<String>(json['id']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      description: serializer.fromJson<String>(json['description']),
      color: serializer.fromJson<String>(json['color']),
      ownerId: serializer.fromJson<String>(json['ownerId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'description': serializer.toJson<String>(description),
      'color': serializer.toJson<String>(color),
      'ownerId': serializer.toJson<String>(ownerId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  NoteTableData copyWith(
          {String? id,
          bool? isCompleted,
          String? description,
          String? color,
          String? ownerId,
          DateTime? createdAt}) =>
      NoteTableData(
        id: id ?? this.id,
        isCompleted: isCompleted ?? this.isCompleted,
        description: description ?? this.description,
        color: color ?? this.color,
        ownerId: ownerId ?? this.ownerId,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('NoteTableData(')
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
      (other is NoteTableData &&
          other.id == this.id &&
          other.isCompleted == this.isCompleted &&
          other.description == this.description &&
          other.color == this.color &&
          other.ownerId == this.ownerId &&
          other.createdAt == this.createdAt);
}

class NoteTableCompanion extends UpdateCompanion<NoteTableData> {
  final Value<String> id;
  final Value<bool> isCompleted;
  final Value<String> description;
  final Value<String> color;
  final Value<String> ownerId;
  final Value<DateTime> createdAt;
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
    required DateTime createdAt,
  })  : id = Value(id),
        isCompleted = Value(isCompleted),
        description = Value(description),
        color = Value(color),
        ownerId = Value(ownerId),
        createdAt = Value(createdAt);
  static Insertable<NoteTableData> custom({
    Expression<String>? id,
    Expression<bool>? isCompleted,
    Expression<String>? description,
    Expression<String>? color,
    Expression<String>? ownerId,
    Expression<DateTime>? createdAt,
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
      Value<DateTime>? createdAt}) {
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
      map['created_at'] = Variable<DateTime>(createdAt.value);
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

class $NoteTableTable extends NoteTable
    with TableInfo<$NoteTableTable, NoteTableData> {
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
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, isCompleted, description, color, ownerId, createdAt];
  @override
  String get aliasedName => _alias ?? 'note_table';
  @override
  String get actualTableName => 'note_table';
  @override
  VerificationContext validateIntegrity(Insertable<NoteTableData> instance,
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
  NoteTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NoteTableData(
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
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $NoteTableTable createAlias(String alias) {
    return $NoteTableTable(attachedDatabase, alias);
  }
}

class CheckListTableData extends DataClass
    implements Insertable<CheckListTableData> {
  final String id;
  final String title;
  final String color;
  final String ownerId;
  final DateTime createdAt;
  const CheckListTableData(
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
    map['created_at'] = Variable<DateTime>(createdAt);
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

  factory CheckListTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CheckListTableData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      color: serializer.fromJson<String>(json['color']),
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
      'color': serializer.toJson<String>(color),
      'ownerId': serializer.toJson<String>(ownerId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CheckListTableData copyWith(
          {String? id,
          String? title,
          String? color,
          String? ownerId,
          DateTime? createdAt}) =>
      CheckListTableData(
        id: id ?? this.id,
        title: title ?? this.title,
        color: color ?? this.color,
        ownerId: ownerId ?? this.ownerId,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('CheckListTableData(')
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
      (other is CheckListTableData &&
          other.id == this.id &&
          other.title == this.title &&
          other.color == this.color &&
          other.ownerId == this.ownerId &&
          other.createdAt == this.createdAt);
}

class CheckListTableCompanion extends UpdateCompanion<CheckListTableData> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> color;
  final Value<String> ownerId;
  final Value<DateTime> createdAt;
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
    required DateTime createdAt,
  })  : id = Value(id),
        title = Value(title),
        color = Value(color),
        ownerId = Value(ownerId),
        createdAt = Value(createdAt);
  static Insertable<CheckListTableData> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? color,
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

  CheckListTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String>? color,
      Value<String>? ownerId,
      Value<DateTime>? createdAt}) {
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
      map['created_at'] = Variable<DateTime>(createdAt.value);
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
    with TableInfo<$CheckListTableTable, CheckListTableData> {
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
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, title, color, ownerId, createdAt];
  @override
  String get aliasedName => _alias ?? 'check_list_table';
  @override
  String get actualTableName => 'check_list_table';
  @override
  VerificationContext validateIntegrity(Insertable<CheckListTableData> instance,
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
  CheckListTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CheckListTableData(
      id: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      color: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}color'])!,
      ownerId: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}owner_id'])!,
      createdAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $CheckListTableTable createAlias(String alias) {
    return $CheckListTableTable(attachedDatabase, alias);
  }
}

class CheckListItemTableData extends DataClass
    implements Insertable<CheckListItemTableData> {
  final String id;
  final String content;
  final bool isCompleted;
  final String? checklistId;
  final DateTime createdAt;
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
    map['created_at'] = Variable<DateTime>(createdAt);
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
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      checklistId: serializer.fromJson<String?>(json['checklistId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'content': serializer.toJson<String>(content),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'checklistId': serializer.toJson<String?>(checklistId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CheckListItemTableData copyWith(
          {String? id,
          String? content,
          bool? isCompleted,
          Value<String?> checklistId = const Value.absent(),
          DateTime? createdAt}) =>
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
  final Value<DateTime> createdAt;
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
    required DateTime createdAt,
  })  : id = Value(id),
        content = Value(content),
        isCompleted = Value(isCompleted),
        createdAt = Value(createdAt);
  static Insertable<CheckListItemTableData> custom({
    Expression<String>? id,
    Expression<String>? content,
    Expression<bool>? isCompleted,
    Expression<String>? checklistId,
    Expression<DateTime>? createdAt,
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
      Value<DateTime>? createdAt}) {
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
      map['created_at'] = Variable<DateTime>(createdAt.value);
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
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
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
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $CheckListItemTableTable createAlias(String alias) {
    return $CheckListItemTableTable(attachedDatabase, alias);
  }
}

abstract class _$AppDb extends GeneratedDatabase {
  _$AppDb(QueryExecutor e) : super(e);
  late final $NoteTableTable noteTable = $NoteTableTable(this);
  late final $CheckListTableTable checkListTable = $CheckListTableTable(this);
  late final $CheckListItemTableTable checkListItemTable =
      $CheckListItemTableTable(this);
  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [noteTable, checkListTable, checkListItemTable];
}
