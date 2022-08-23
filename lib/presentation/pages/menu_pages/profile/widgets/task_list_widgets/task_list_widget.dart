import 'package:flutter/material.dart';
import 'package:todo2/database/model/profile_models/stats_model.dart';
import 'package:todo2/database/model/project_models/projects_model.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/constants/stats_contstants.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/widgets/stats_widget/stats_widget.dart';
import 'package:todo2/presentation/widgets/common/disabled_scroll_glow_widget.dart';

class TaskListWidget extends StatelessWidget {
  final StatsModel model;
  const TaskListWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
          width: double.infinity,
          height: 110,
          child: DisabledGlowWidget(
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: labels.length,
                itemBuilder: (BuildContext context, i) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 160,
                      height: 100,
                      decoration: BoxDecoration(
                        color: statsColors[i],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ListTile(
                        title: Text(
                          labels[i],
                          style: const TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w200,
                            color: Colors.white,
                          ),
                        ),
                        subtitle: const Text(
                          '12 tasks',
                          style: TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.normal,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          )),
    );
  }
}
/*
import 'package:flutter/material.dart';
import 'package:todo2/database/model/project_models/projects_model.dart';

class TaskListWidget extends StatelessWidget {
  final AsyncSnapshot<List<ProjectModel>> snapshot;
  const TaskListWidget({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: SizedBox(
          width: double.infinity,
          height: 110,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, index) {
                final data = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 160,
                    height: 100,
                    decoration: BoxDecoration(
                      color: data.color,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ListTile(
                      title: Text(
                        data.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                        ),
                      ),
                      subtitle: const Text(
                        '12 tasks',
                        style: TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.normal,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              })),
    );
  }
}

*/