import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo2/database/model/task_models/task_model.dart';
import 'package:todo2/database/repository/auth_repository.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/controller/refresh_token_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/task_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/task/dialogs/tasks_dialog.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/calendar_lib/widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/list/list_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/tabs/bottom_tabs.dart';
import 'package:todo2/presentation/pages/navigation/widgets/keep_page_alive.dart';
import 'package:todo2/presentation/widgets/common/progress_indicator_widget.dart';
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

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final taskController = AddTaskController();

  final _secureStorageService = SecureStorageSource();
  final _networkSource = NetworkSource();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WillPopWrap(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // ac1c2520-9d8b-4e15-b025-9943ccdf8f84
            final refreshToken = await _secureStorageService.getUserData(
              type: StorageDataType.refreshToken,
            );
            log('refreshToken $refreshToken');
            log('before  response');
       await      RefreshTokenController(authRepository: AuthRepositoryImpl(),
secureStorageService: SecureStorageSource(),).updateToken();
          
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
          title: const Text(
            'Work List',
            style: TextStyle(
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
            tabs: const [todayTab, monthTab],
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
                  child: FutureBuilder(
                      initialData: const <TaskModel>[],
                      future: taskController.fetchTasks(),
                      builder: (_, AsyncSnapshot<List<TaskModel>> snapshots) {
                        final data = snapshots.data!;
                        if (!snapshots.hasData || snapshots.data == null) {
                          return const Center(
                            child: ProgressIndicatorWidget(text: 'No data'),
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
                            return const Center(
                                child:
                                    ProgressIndicatorWidget(text: 'No data'));
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
