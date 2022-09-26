import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo2/database/model/task_models/task_model.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/task_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/task/dialogs/tasks_dialog.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/calendar_lib/widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/list/list_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/tabs/bottom_tabs.dart';
import 'package:todo2/presentation/pages/navigation/widgets/keep_page_alive.dart';
import 'package:todo2/presentation/widgets/common/progress_indicator_widget.dart';
import 'package:todo2/presentation/widgets/common/will_pop_scope_wrapp.dart';
import 'package:todo2/services/theme_service/theme_data_controller.dart';
import 'package:todo2/utils/assets_path.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({Key? key}) : super(key: key);
  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late final _tabController =
      ValueNotifier<TabController>(TabController(length: 2, vsync: this));

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final taskController = AddTaskController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WillPopWrap(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await context.setLocale(const Locale('en'));
          },
        ),
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
            ValueListenableBuilder<TabController>(
              valueListenable: _tabController,
              builder: (_, tabController, __) => tabController.index == 0
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: SvgPicture.asset(AssetsPath.tuneIconPath),
                        onTap: () => showTasksDialog(context),
                      ),
                    )
                  : const SizedBox(),
            ),
          ],
          bottom: TabBar(
            onTap: (value) =>
                taskController.changeTabIndexValue(value, _tabController),
            splashFactory: NoSplash.splashFactory,
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            controller: _tabController.value,
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
            controller: _tabController.value,
            children: [
              // TODO remove 2 requests, 1 only
              // today
              SingleChildScrollView(
                child: KeepAlivePageWidget(
                  child: FutureBuilder(
                      initialData: const <TaskModel>[],
                      future: taskController.fetchTasks(),
                      builder: (_, AsyncSnapshot<List<TaskModel>> snapshots) {
                        final data = snapshots.data!;
                        if (!snapshots.hasData || snapshots.data == null) {
                          return Center(
                            child: ProgressIndicatorWidget(
                                text: LocaleKeys.no_data.tr()),
                          );
                        } else {
                          return Column(
                            children: [
                              ListWidget(
                                modelList: data,
                                isToday: true,
                              ),
                              ListWidget(
                                modelList: data,
                                isToday: false,
                              ),
                            ],
                          );
                        }
                      }),
                ),
              ),

              // month
              SingleChildScrollView(
                child: KeepAlivePageWidget(
                  child: Column(children: [
                    AdvancedCalendar(
                      controller: taskController.calendarController,
                      events: taskController.events,
                    ),
                    FutureBuilder(
                        initialData: const <TaskModel>[],
                        future: taskController.fetchTasks(),
                        builder: (_, AsyncSnapshot<List<TaskModel>> snapshots) {
                          final data = snapshots.data!;
                          if (!snapshots.hasData || snapshots.data == null) {
                            return Center(
                              child: ProgressIndicatorWidget(
                                text: LocaleKeys.no_data.tr(),
                              ),
                            );
                          } else {
                            return Column(
                              children: [
                                ListWidget(
                                  modelList: data,
                                  isToday: true,
                                ),
                                ListWidget(
                                  modelList: data,
                                  isToday: false,
                                ),
                              ],
                            );
                          }
                        }),
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
