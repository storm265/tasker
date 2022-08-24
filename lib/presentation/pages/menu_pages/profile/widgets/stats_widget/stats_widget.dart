import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:todo2/database/model/profile_models/stats_model.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/constants/stats_contstants.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/constants/stats_padding_constants.dart';

class StatsWidget extends StatelessWidget {
  final StatsModel statsModel;

  const StatsWidget({
    Key? key,
    required this.statsModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        height: 210,
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
                    fontWeight: FontWeight.w200,
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
                            radius: 40.0,
                            lineWidth: 2.0,
                            percent: 0.3,
                            // percent: double.parse(
                            //         stats[index].removeLastElement()) /
                            //     100,
                            center: const Center(
                              child: Text(
                                '35%',
                                style: TextStyle(
                                  fontWeight: FontWeight.w200,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            progressColor: statsColors[index],
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
