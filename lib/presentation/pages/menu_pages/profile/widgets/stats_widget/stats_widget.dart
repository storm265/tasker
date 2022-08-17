import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:todo2/database/data_source/user_data_source.dart';
import 'package:todo2/database/model/profile_models/stats_model.dart';
import 'package:todo2/database/model/project_models/projects_model.dart';
import 'package:todo2/database/repository/user_repository.dart';
import 'package:todo2/presentation/controller/user_controller.dart';
import 'package:todo2/presentation/widgets/common/disabled_scroll_glow_widget.dart';
import 'package:todo2/presentation/widgets/common/progress_indicator_widget.dart';
import 'package:todo2/services/storage/secure_storage_service.dart';

class StatsWidget extends StatelessWidget {
  final AsyncSnapshot<List<ProjectModel>> projectList;
   StatsWidget({Key? key, required this.projectList}) : super(key: key);
  final UserController userController = UserController(
    userProfileRepository: UserProfileRepositoryImpl(
      userProfileDataSource: UserProfileDataSourceImpl(
        secureStorageService: SecureStorageService(),
      ),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return projectList.data!.isEmpty
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
                      child: FutureBuilder(
                        future: userController.fetchUserStatistics(),
                        builder: (_,AsyncSnapshot<StatsModel> snapshot) {
                        return snapshot.hasData
                            ? ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 4,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final color = projectList.data![index].color;
                           
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24),
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
                                                color: color,),
                                          ),
                                          progressColor:color,
                                        ),
                                        // Padding(
                                        //   padding:
                                        //       const EdgeInsets.only(top: 10),
                                        //   child: Text(model[index]),
                                        // ),
                                      ],
                                    ),
                                  );
                                },
                              )
                            : const ProgressIndicatorWidget();
                      }),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
