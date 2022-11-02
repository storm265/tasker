import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/controller/detailed_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/project_item_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/task_sort_provider.dart';
import 'package:todo2/presentation/pages/menu_pages/task/dialogs/tasks_filter_dialog.dart';
import 'package:todo2/presentation/pages/menu_pages/task/tasks_widgets/calendar_lib/controller.dart';
import 'package:todo2/presentation/pages/menu_pages/task/tasks_widgets/calendar_lib/widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/tasks_widgets/list/task_list_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/tasks_widgets/tabs/bottom_tabs.dart';
import 'package:todo2/presentation/pages/navigation/controllers/inherited_navigator.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/presentation/widgets/common/will_pop_scope_wrapp.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/services/secure_storage_service.dart';
import 'package:todo2/utils/assets_path.dart';

class DetailedPage extends StatefulWidget {
  const DetailedPage({Key? key}) : super(key: key);
  @override
  State<DetailedPage> createState() => _DetailedPageState();
}

class _DetailedPageState extends State<DetailedPage>
    with SingleTickerProviderStateMixin {
  late final _tabController = TabController(length: 2, vsync: this);

  final _taskController = DetailedController(
    calendarProvider: CalendarProvider(),
    secureStorage: SecureStorageSource(),
  );

  final _taskSortControllerMonth = TaskSortProvider();
  final _taskSortControllerToday = TaskSortProvider();

  @override
  void initState() {
    _taskController.getInitData(
      callback: () => setState(() {}),
      projectId: detailedId,
    );
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final navigationController =
        NavigationInherited.of(context).navigationController;
    return WillPopWrap(
      child: Scaffold(
        backgroundColor: const Color(0xffFDFDFD),
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: getAppColor(color: CategoryColor.blue),
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.light,
          ),
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: GestureDetector(
              onTap: () async {
                FocusScope.of(context).unfocus();
                await navigationController.moveToPage(Pages.menu);
              },
              child: const Icon(
                Icons.west_rounded,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: getAppColor(color: CategoryColor.blue),
          centerTitle: true,
          title: Text(
            projectTitle,
            style: const TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w200,
            ),
          ),
          actions: [
            ValueListenableBuilder(
              valueListenable: _taskController.isTuneIconActive,
              builder: (_, isActive, __) => isActive
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: SvgPicture.asset(AssetsPath.tuneIconPath),
                        onTap: () => showTasksFilterDialog(
                          context: context,
                          taskController: _taskController,
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
                taskSortController: _taskSortControllerToday,
                taskController: _taskController,
                calendarWorkMode: TaskMode.todayTomorrow,
              ),
              ListView(
                children: [
                  AdvancedCalendar(
                    calendarProvider: _taskController.calendarProvider,
                    controller: _taskController.selectedDate,
                    events: _taskController.events,
                    taskController: _taskController,
                  ),
                  TaskListWidget(
                    taskSortController: _taskSortControllerMonth,
                    taskController: _taskController,
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
