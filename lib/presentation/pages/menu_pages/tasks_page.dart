import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/presentation/widgets/menu_pages/work_list/widgets/app_bar_widget.dart';
import 'package:todo2/presentation/widgets/menu_pages/work_list/widgets/calendar_lib/table_calendar.dart';
import 'package:todo2/presentation/widgets/menu_pages/work_list/widgets/circle_widget.dart';
import 'package:todo2/presentation/widgets/menu_pages/work_list/widgets/list/list_widget.dart';
import 'package:todo2/presentation/widgets/menu_pages/work_list/widgets/slidable_widgets/endpane_widget.dart';
import 'package:todo2/presentation/widgets/menu_pages/work_list/widgets/slidable_widgets/grey_slidable_widget.dart';

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
    return Scaffold(
      appBar: AppBarWorkList(
        tabController: _tabController,
      ),
      body: Column(
        children: [
          TableCalendar(
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) => _calendarFormat = format,
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
                ListView.builder(
                  itemCount: 10,
                  itemBuilder: ((context, index) {
                    return ListWidget(index: index);
                  }),
                ),
                // month
                Column(children: const [Text('dadiadhjiajdad ')])
              ],
            ),
          ),
        ],
      ),
    );
  }
}
