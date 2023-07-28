import 'package:todo2/schemas/database_scheme/stats_scheme.dart';

class StatsModel {
  StatsModel({
    required this.createdTasks,
    required this.completedTasks,
    required this.events,
    required this.quickNotes,
    required this.todo,
  });

  final int createdTasks;

  final int completedTasks;

  final String events;

  final String quickNotes;

  final String todo;

  factory StatsModel.fromJson(Map<String, dynamic> json) => StatsModel(
        createdTasks: json[StatsScheme.createdTasks],
        completedTasks: json[StatsScheme.completedTasks],
        events: json[StatsScheme.events],
        quickNotes: json[StatsScheme.quickNotes],
        todo: json[StatsScheme.todo],
      );
}
