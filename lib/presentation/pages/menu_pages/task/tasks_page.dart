import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/app_bar_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/calendar_lib/table_calendar.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/list/list_widget.dart';
import 'package:todo2/presentation/widgets/common/disabled_glow_single_child_scroll_widget.dart';
import 'package:todo2/presentation/widgets/common/will_pop_scope_wrapper.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage>
    with SingleTickerProviderStateMixin {
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

  DateTime _selectedDay = DateTime.now();
  var _calendarFormat = CalendarFormat.week;
  @override
  Widget build(BuildContext context) {
    return WillPopWrapper(
      child: Scaffold(
        appBar: AppBarWorkList(
          tabController: _tabController,
        ),
        body: Column(
          children: [
            TableCalendar(
              shouldHideButton: false,
              calendarFormat: _calendarFormat,
              onFormatChanged: (format) => setState(() {
                _calendarFormat = format;
              }),
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                });
              },
              firstDay: DateTime.utc(DateTime.now().year - 1, 1, 1),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: _selectedDay,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  DisabledGlowWidget(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: 10,
                      itemBuilder: ((context, index) {
                        return ListWidget(index: index);
                      }),
                    ),
                  ),
                  // month
                  Column(children: const [Text('dadiadhjiajdad ')])
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
