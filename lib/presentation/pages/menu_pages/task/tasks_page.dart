import 'package:flutter/material.dart';
import 'package:todo2/database/repository/task_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/task/dialogs/tasks_dialog.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/calendar_lib/table_calendar.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/tabs/bottom_tabs.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({Key? key}) : super(key: key);
  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late final taskController = TaskRepositoryImpl();
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

  DateTime _selectedDay = DateTime.now();
  var _calendarFormat = CalendarFormat.week;
  @override
  Widget build(BuildContext context) {
    return AppbarWrapperWidget(
      preferredHeight: 90,
      showLeadingButton: false,
      actionWidget: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          child: const Icon(Icons.tune_outlined),
          onTap: () => showTasksDialog(context),
        ),
      ),
      title: 'Work list',
      bottom: TabBar(
        indicatorColor: Colors.white,
        controller: _tabController,
        tabs: const [todayTab, monthTab],
      ),
      child: Column(
        children: [
          TableCalendar(
            shouldHideButton: false,
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) =>
                setState(() => _calendarFormat = format),
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) =>
                setState(() => _selectedDay = selectedDay),
            firstDay: DateTime.utc(DateTime.now().year - 1, 1, 1),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _selectedDay,
          ),
          // Expanded(
          //   child: TabBarView(
          //     controller: _tabController,
          //     children: [
          //       Container(),
          //       DisabledGlowWidget(
          //         child: FutureBuilder<List<TaskModel>>(
          //             future: taskController.fetchTask(),
          //             initialData: const [],
          //             builder:
          //                 (context, AsyncSnapshot<List<TaskModel>> snapshot) {
          //               if (snapshot.data!.isEmpty) {
          //                 return const Center(
          //                   child: Text(
          //                     'No tasks',
          //                     style:
          //                         TextStyle(color: Colors.black, fontSize: 20),
          //                   ),
          //                 );
          //               } else if (snapshot.hasData) {
          //                 return ListView.builder(
          //                   scrollDirection: Axis.vertical,
          //                   itemCount: snapshot.data!.length,
          //                   itemBuilder: ((context, index) => ListWidget(
          //                         index: index,
          //                         model: snapshot.data!,
          //                       )),
          //                 );
          //               } else {
          //                 return const Center(
          //                   child:  ProgressIndicatorWidget(),
          //                 );
          //               }
          //             }),
          //       ),
          //       // month
          //       Column(children: const [Text('dadiadhjiajdad ')])
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
