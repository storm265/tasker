// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatsModel _$StatsModelFromJson(Map<String, dynamic> json) => StatsModel(
      createdTasks: json['createdTasks'] as int,
      completedTasks: json['completedTasks'] as int,
      events: json['events'] as String,
      quickNotes: json['quickNotes'] as String,
      todo: json['todo'] as String,
    );

Map<String, dynamic> _$StatsModelToJson(StatsModel instance) =>
    <String, dynamic>{
      'createdTasks': instance.createdTasks,
      'completedTasks': instance.completedTasks,
      'events': instance.events,
      'quickNotes': instance.quickNotes,
      'todo': instance.todo,
    };
