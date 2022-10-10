import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:todo2/database/model/profile_models/stats_model.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/constants/stats_contstants.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/constants/stats_padding_constants.dart';
import 'package:todo2/presentation/widgets/common/disabled_scroll_glow_widget.dart';
import 'package:todo2/utils/extensions/remove_last_element.dart';

class StatsWidget extends StatelessWidget {
  final StatsModel statsModel;
  const StatsWidget({
    Key? key,
    required this.statsModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> stats = [
      statsModel.events,
      statsModel.todo,
      statsModel.quickNotes,
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: horizontal,
        vertical: vertical,
      ),
      child: Container(
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 25,
                  top: 20,
                  bottom: 20,
                ),
                child: Text(
                  LocaleKeys.statistic.tr(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w200,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
            FittedBox(
              child: SizedBox(
                height: 130,
                child: DisabledGlowWidget(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    shrinkWrap: true,
                    itemBuilder: (_, i) {
                      return Center(
                        child: SizedBox(
                          width: 120,
                          child: Column(
                            children: [
                              CircularPercentIndicator(
                                addAutomaticKeepAlive: false,
                                animation: true,
                                radius: 36.0,
                                lineWidth: 2.3,
                                percent:
                                    double.parse(stats[i].removeLastElement()) /
                                        100,
                                center: Center(
                                  child: Text(
                                    stats[i],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                progressColor: statsColors[i],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Text(
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  labels[i],
                                  style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
