import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo2/database/model/task_models/task_model.dart';
import 'package:todo2/database/repository/task_repository.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/tasks_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/task/dialogs/tasks_filter_dialog.dart';
import 'package:todo2/presentation/pages/menu_pages/task/tasks_widgets/calendar_lib/widget.dart';

import 'package:todo2/presentation/pages/menu_pages/task/tasks_widgets/list/task_item_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/tasks_widgets/list/today_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/tasks_widgets/tabs/bottom_tabs.dart';
import 'package:todo2/presentation/widgets/common/slidable_widgets/endpane_widget.dart';
import 'package:todo2/presentation/widgets/common/slidable_widgets/grey_slidable_widget.dart';
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
    taskController.generateCalendarEvents();
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
    generateHeader();

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
                  : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: getDaysLength(isTodayMode: true),
                      shrinkWrap: true,
                      itemBuilder: (_, i) {
                        final sortedList = sorter(taskController.tasks, i);
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              HeaderWidget(text: headers[i]),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: sortedList.length,
                                itemBuilder: (_, index) => Slidable(
                                  key: const ValueKey(0),
                                  endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      EndPageWidget(
                                        iconPath: AssetsPath.editIconPath,
                                        onClick: () {
                                          // TODO implement edit function
                                        },
                                      ),
                                      const GreySlidableWidget(),
                                      EndPageWidget(
                                        iconPath: AssetsPath.deleteIconPath,
                                        onClick: () async =>
                                            await taskController.deleteTask(
                                          taskId: sortedList[index].projectId,
                                        ),
                                      ),
                                    ],
                                  ),
                                  child: TaskCardWidget(
                                    taskController: taskController,
                                    model: sortedList[index],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
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
                          itemCount: getDaysLength(isTodayMode: false),
                          shrinkWrap: true,
                          itemBuilder: (_, i) {
                            final sortedList = sorter(taskController.tasks, i);
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  HeaderWidget(text: headers[i]),
                                  ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: sortedList.length,
                                    itemBuilder: (_, index) => Slidable(
                                      key: const ValueKey(0),
                                      endActionPane: ActionPane(
                                        motion: const ScrollMotion(),
                                        children: [
                                          EndPageWidget(
                                            iconPath: AssetsPath.editIconPath,
                                            onClick: () {
                                              // TODO implement edit function
                                            },
                                          ),
                                          const GreySlidableWidget(),
                                          EndPageWidget(
                                            iconPath: AssetsPath.deleteIconPath,
                                            onClick: () async =>
                                                await taskController.deleteTask(
                                              taskId:
                                                  sortedList[index].projectId,
                                            ),
                                          ),
                                        ],
                                      ),
                                      child: TaskCardWidget(
                                        taskController: taskController,
                                        model: sortedList[index],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
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

final now = DateTime.now();
final formatter = DateFormat('yyyy-MM-dd');

List<TaskModel> sorter(List<TaskModel> tasks, int index) {
  List<TaskModel> sortedList = [];
  if (index == 0) {
    sortedList = tasks
        .where(
          (element) =>
              formatter.format(element.dueDate) ==
              formatter.format(
                DateTime.utc(now.year, now.month, now.day),
              ),
        )
        .toList();
    sortedList.sort((a, b) => a.dueDate.compareTo(b.dueDate));
  }
  if (index == 1) {
    sortedList = tasks
        .where(
          (element) =>
              formatter.format(element.dueDate) ==
              formatter.format(
                DateTime.utc(now.year, now.month, now.day + 1),
              ),
        )
        .toList();
    sortedList.sort((a, b) => a.dueDate.compareTo(b.dueDate));
  } else {
    sortedList = tasks
        .where(
          (element) =>
              formatter.format(element.dueDate) ==
              formatter.format(
                DateTime.utc(now.year, now.month, now.day + index),
              ),
        )
        .toList();
    sortedList.sort((a, b) => a.dueDate.compareTo(b.dueDate));
  }
  return sortedList;
}

// header generator

List<String> headers = [];
void generateHeader({bool isTodayMode = false}) {
  for (var i = 0; i < getDaysLength(isTodayMode: isTodayMode); i++) {
    if (i == 0) {
      headers.add(
          '${LocaleKeys.today.tr()} ${DateFormat('MMM').format(now)} ${now.day}/${now.year}');
    }
    if (i == 1) {
      headers.add(
          '${LocaleKeys.tomorrow.tr()}  ${DateFormat('MMM').format(now)} ${now.day + 1}/${now.year}');
    }
    if (i > 1) {
      headers
          .add('${DateFormat('MMM').format(now)} ${now.day + i}/${now.year}');
    }
  }
}

int getDaysLength({bool isTodayMode = false}) {
  if (isTodayMode) {
    return 2;
  } else {
    final now = DateTime.now();
    DateTime x1 = now.toUtc();
    return DateTime(now.year, now.month + 1, 0).toUtc().difference(x1).inDays +
        2;
  }
}
