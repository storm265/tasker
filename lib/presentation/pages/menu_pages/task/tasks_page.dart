import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo2/database/database_scheme/auth_scheme.dart';
import 'package:todo2/database/model/auth_model.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/task_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/task/dialogs/tasks_filter_dialog.dart';
import 'package:todo2/presentation/pages/menu_pages/task/tasks_widgets/calendar_lib/widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/tasks_widgets/list/list_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/tasks_widgets/tabs/bottom_tabs.dart';
import 'package:todo2/presentation/pages/navigation/widgets/keep_page_alive.dart';
import 'package:todo2/presentation/widgets/common/will_pop_scope_wrapp.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/services/theme_service/theme_data_controller.dart';
import 'package:todo2/storage/secure_storage_service.dart';
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

  final taskController = AddTaskController();
  @override
  void initState() {
    taskController.fetchTasks();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final ss = SecureStorageSource();
  final netwokr = NetworkSource();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WillPopWrap(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // "YYYY-MM-dd'T'hh:mm:ss.ssssss" -- srs
            // '2022-09-29T12:00:00.000Z' --my
            // final refreshToken =
            //     await ss.getUserData(type: StorageDataType.refreshToken);
            // log('token $refreshToken');
            // Response response = await netwokr.post(
            //   path: '/refresh-token',
            //   data: {
            //     "refresh_token": refreshToken,
            //   },
            //   //     options: netwokr.authOptions,
            //   options: Options(
            //     headers: {'Content-Type': 'application/json'},
            //   ),
            // );

            // log('refresh response ${response.statusCode}');
            // log('refresh response ${response.statusMessage}');
            // log('refresh response ${response.data}');

            // final map = response.data[AuthScheme.data] as Map<String, dynamic>;
            // final model = AuthModel.fromJson(json: map);
            // log('model ${model.refreshToken}');
            // await ss.saveData(
            //   type: StorageDataType.accessToken,
            //   value: model.accessToken,
            // );
            // await ss.saveData(
            //   type: StorageDataType.refreshToken,
            //   value: model.refreshToken,
            // );
            // await taskController.fetchTasks();
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
                        onTap: () => showTasksFilterDialog(context),
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
              // today
              SingleChildScrollView(
                child: KeepAlivePageWidget(
                  child: Column(
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
                    Column(
                      children: [
                        // ListWidget(
                        //   taskController: taskController,
                        //   modelList: taskController.tasks,
                        //   isToday: true,
                        // ),
                        // ListWidget(
                        //   taskController: taskController,
                        //   modelList: taskController.tasks,
                        //   isToday: false,
                        // ),
                      ],
                    ),
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
