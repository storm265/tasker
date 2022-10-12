import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/database/model/profile_models/stats_model.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/constants/stats_contstants.dart';
import 'package:todo2/presentation/widgets/common/disabled_scroll_glow_widget.dart';

class TaskListWidget extends StatelessWidget {
  final List<int> cardLength;
  final StatsModel model;
  const TaskListWidget({
    Key? key,
    required this.cardLength,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 120,
      child: DisabledGlowWidget(
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: labels.length,
            itemBuilder: (BuildContext context, i) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 10,
                ),
                child: Container(
                  width: 160,
                  height: 100,
                  decoration: BoxDecoration(
                    color: statsColors[i],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.only(
                      left: 15,
                      top: 10,
                    ),
                    title: Text(
                      labels[i],
                      style: const TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w200,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      '${cardLength[i]}  ${cardLength[i] > 4 ? LocaleKeys.task.tr() : LocaleKeys.tasks.tr()}',
                      style: const TextStyle(
                        fontStyle: FontStyle.normal,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
