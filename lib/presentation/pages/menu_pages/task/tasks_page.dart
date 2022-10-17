import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo2/database/repository/task_repository.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/task_sort_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/tasks_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/task/dialogs/tasks_filter_dialog.dart';
import 'package:todo2/presentation/pages/menu_pages/task/tasks_widgets/calendar_lib/controller.dart';
import 'package:todo2/presentation/pages/menu_pages/task/tasks_widgets/calendar_lib/widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/tasks_widgets/list/task_list_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/tasks_widgets/tabs/bottom_tabs.dart';
import 'package:todo2/presentation/widgets/common/will_pop_scope_wrapp.dart';
import 'package:todo2/services/theme_service/theme_data_controller.dart';
import 'package:todo2/utils/assets_path.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({Key? key}) : super(key: key);
  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage>
    with SingleTickerProviderStateMixin {
  late final _tabController = TabController(length: 2, vsync: this);

  final taskController = TaskListController(
    taskRepository: TaskRepositoryImpl(),
  );

  final taskSortControllerMonth = TaskSortController();
  final taskSortControllerToday = TaskSortController();

  @override
  void initState() {
    taskController.fetchInitData(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWrap(
      child: Scaffold(
        backgroundColor: const Color(0xffFDFDFD),
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Palette.red,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.light,
          ),
          elevation: 0,
          backgroundColor: Palette.red,
          centerTitle: true,
          title: Text(
            LocaleKeys.work_list.tr(),
            style: const TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w200,
            ),
          ),
          actions: [
            ValueListenableBuilder(
              valueListenable: taskController.isTuneIconActive,
              builder: (_, isActive, __) => isActive
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: SvgPicture.asset(AssetsPath.tuneIconPath),
                        onTap: () => showTasksFilterDialog(
                          context: context,
                          taskController: taskController,
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
          ],
          bottom: TabBar(
            indicatorWeight: 3,
            onTap: (value) => _tabController.index = value,
            splashFactory: NoSplash.splashFactory,
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            controller: _tabController,
            tabs: [todayTab, monthTab],
            labelStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: SafeArea(
          maintainBottomViewPadding: true,
          bottom: false,
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: [
              TaskListWidget(
                taskSortController: taskSortControllerToday,
                taskController: taskController,
                isTodayMode: true,
              ),
              ListView(
                children: [
                  AdvancedCalendar(
                    calendarProvider: CalendarProvider(),
                    controller: taskController.selectedDate,
                    events: taskController.events,
                    taskController: taskController,
                  ),
                  TaskListWidget(
                    taskSortController: taskSortControllerMonth,
                    taskController: taskController,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
