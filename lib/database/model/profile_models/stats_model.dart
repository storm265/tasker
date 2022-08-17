import 'package:json_annotation/json_annotation.dart';

part 'stats_model.g.dart';

@JsonSerializable()
class StatsModel {
  final int createdTasks;
  final int completedTasks;
  final String events;
  final String quickNotes;
  final String todo;

  StatsModel({
    required this.createdTasks,
    required this.completedTasks,
    required this.events,
    required this.quickNotes,
    required this.todo,
  });

  factory StatsModel.fromJson(Map<String, dynamic> json) =>
      _$StatsModelFromJson(json);

  Map toJson() => _$StatsModelToJson(this);
}
