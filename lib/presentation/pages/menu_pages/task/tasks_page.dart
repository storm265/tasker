import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo2/database/model/task_models/task_model.dart';
import 'package:todo2/database/repository/task_repository.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/tasks_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/task/dialogs/tasks_filter_dialog.dart';
import 'package:todo2/presentation/pages/menu_pages/task/tasks_widgets/calendar_lib/widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/tasks_widgets/list/list_widget.dart';
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
  @override
  void initState() {
    log('initState tasks');
    taskController.getAccessHeader();
    taskController.fetchTasks().then((_) => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    log('dispose tasks');
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
                        onTap: () => showTasksFilterDialog(context),
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
              // today
              taskController.tasks.isEmpty
                  ? const Center(
                      // TRANSLATE
                      child: Text('No tasks'),
                    )
                  : Column(
                      children: [
                        ListWidget(
                          taskController: taskController,
                          modelList: taskController.tasks,
                          isToday: true,
                        ),
                        ListWidget(
                          taskController: taskController,
                          modelList: taskController.tasks,
                          isToday: false,
                        ),
                      ],
                    ),
              // month
              SingleChildScrollView(
                child: Column(children: [
                  AdvancedCalendar(
                    controller: taskController.calendarController,
                    events: taskController.events,
                    taskController: taskController,
                  ),
                  taskController.tasks.isEmpty
                      ? const Center(
                          // TRANSLATE
                          child: Text('No tasks'),
                        )
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: getDaysLenInMonth(),
                          shrinkWrap: true,
                          itemBuilder: (_, i) => ListWidget(
                            
                            taskController: taskController,
                            modelList: taskController.tasks,
                            isToday: true,
                          ),
                        ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}

int getDaysLenInMonth() {
  final now = DateTime.now();
  DateTime x1 = now.toUtc();
  return DateTime(now.year, now.month + 1, 0).toUtc().difference(x1).inDays;
}

enum TaskCategory {
  today,
  tomorrow,
  next,
}

class Task {
  TaskModel model;
  TaskCategory category;

  Task(
    this.category,
    this.model,
  );
}
