import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:todo2/database/data_source/user_data_source.dart';
import 'package:todo2/database/model/profile_models/stats_model.dart';
import 'package:todo2/database/model/project_models/projects_model.dart';
import 'package:todo2/database/repository/user_repository.dart';
import 'package:todo2/presentation/controller/user_controller.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/presentation/widgets/common/disabled_scroll_glow_widget.dart';
import 'package:todo2/presentation/widgets/common/progress_indicator_widget.dart';
import 'package:todo2/services/extensions/remove_last_element.dart';
import 'package:todo2/services/storage/secure_storage_service.dart';

class StatsWidget extends StatelessWidget {
  StatsWidget({
    Key? key,
    required this.statsModel,
  }) : super(key: key);
  final StatsModel statsModel;
  final List<String> labels = [
    'Events',
    'Todo',
    'Quick Notes',
  ];

  @override
  Widget build(BuildContext context) {
    final List<String> stats = [
      statsModel.events,
      statsModel.todo,
      statsModel.quickNotes,
    ];
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE0E0E0).withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 2),
          )
        ],
        color: const Color(0xFFFFFFFF),
      ),
      height: 190,
      child: DisabledGlowWidget(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Statistic',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
              SizedBox(
                  width: double.infinity,
                  height: 120,
                  child: Center(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularPercentIndicator(
                                radius: 32.0,
                                lineWidth: 2.0,
                                percent: double.parse(
                                        stats[index].removeLastElement()) /
                                    100,
                                center: Text(
                                  stats[index],
                                  style: TextStyle(
                                    color: colors[index],
                                  ),
                                ),
                                progressColor: colors[index],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  labels[index],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
