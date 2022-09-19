import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo2/database/model/task_models/task_model.dart';
import 'package:todo2/database/repository/task_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/task/dialogs/tasks_dialog.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/calendar_lib/controller.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/calendar_lib/widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/list/list_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/tabs/bottom_tabs.dart';
import 'package:todo2/presentation/pages/navigation/widgets/keep_page_alive.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/presentation/widgets/common/disabled_scroll_glow_widget.dart';
import 'package:todo2/presentation/widgets/common/progress_indicator_widget.dart';
import 'package:todo2/utils/assets_path.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({Key? key}) : super(key: key);
  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final _calendarControllerToday = AdvancedCalendarController.today();
  
  final List<DateTime> events = [
    DateTime.utc(2022, 09, 19, 12),
    DateTime.utc(2022, 09, 20, 12),
    DateTime.utc(2022, 09, 21, 12),
    DateTime.utc(2022, 09, 22, 12),
    DateTime.utc(2022, 09, 23, 12),
  ];
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AppbarWrapWidget(
      preferredHeight: 90,
      showLeadingButton: false,
      actionWidget: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          child: SvgPicture.asset(AssetsPath.tuneIconPath),
          onTap: () => showTasksDialog(context),
        ),
      ),
      title: 'Work list',
      bottom: TabBar(
        splashFactory: NoSplash.splashFactory,
        indicatorColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.label,
        controller: _tabController,
        tabs: const [todayTab, monthTab],
        labelStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      child: TabBarView(
        controller: _tabController,
        children: [
          KeepAlivePageWidget(
            child: Column(
              children: [
                AdvancedCalendar(
                  controller: _calendarControllerToday,
                  events: events,
                ),
              ],
            ),
          ),

          // DisabledGlowWidget(
          //   child: FutureBuilder<List<TaskModel>>(
          //       future: taskController.fetchTask(),
          //       initialData: const [],
          //       builder:
          //           (context, AsyncSnapshot<List<TaskModel>> snapshot) {
          //         if (snapshot.data!.isEmpty) {
          //           return const Center(
          //             child: Text(
          //               'No tasks',
          //               style:
          //                   TextStyle(color: Colors.black, fontSize: 20),
          //             ),
          //           );
          //         } else if (snapshot.hasData) {
          //           return ListView.builder(
          //             scrollDirection: Axis.vertical,
          //             itemCount: snapshot.data!.length,
          //             itemBuilder: ((context, index) => ListWidget(
          //                   index: index,
          //                   model: snapshot.data!,
          //                 )),
          //           );
          //         } else {
          //           return const Center(
          //             child: ProgressIndicatorWidget(),
          //           );
          //         }
          //       }),
          // ),
          // month
          KeepAlivePageWidget(
            child: Column(children: [
              AdvancedCalendar(
                controller: _calendarControllerToday,
                events: events,
                isMonthMode: true,
              ),
              const Text('disabled ')
            ]),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
