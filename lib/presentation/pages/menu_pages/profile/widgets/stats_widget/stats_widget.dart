import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:todo2/database/model/projects_model.dart';
import 'package:todo2/presentation/widgets/common/disabled_scroll_glow_widget.dart';

class StatsWidget extends StatelessWidget {
  final AsyncSnapshot<List<ProjectModel>> snapshot;
  const StatsWidget({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return snapshot.data!.isEmpty
        ? const SizedBox()
        : Container(
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
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final data = snapshot.data![index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircularPercentIndicator(
                                  radius: 32.0,
                                  lineWidth: 2.0,
                                  percent: 0.5,
                                  center: Text(
                                    "100%",
                                    style: TextStyle(
                                      color: data.color
                                    ),
                                  ),
                                  progressColor:data.color,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(data.title),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
