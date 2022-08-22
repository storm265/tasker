import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/calendar_lib/date_line_fonts.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/calendar_lib/task_list_controller.dart';
import 'package:todo2/services/theme_service/theme_data_controller.dart';

class DayLineWidget extends StatefulWidget {
  const DayLineWidget({Key? key}) : super(key: key);

  @override
  State<DayLineWidget> createState() => _DayLineWidgetState();
}

class _DayLineWidgetState extends State<DayLineWidget> {
  final _taskListController = TaskListController();

  @override
  void initState() {
    _taskListController.generateCalendar();
    _taskListController.findIndexThenScroll();
    _taskListController.updateCalendar(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    _taskListController.dispose();
    _taskListController.pageController.dispose();
    _taskListController.selectedDate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ValueListenableBuilder(
          valueListenable: _taskListController.selectedDate,
          builder: (_, selectedDate, __) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat.yMMMM()
                            .format(_taskListController.selectedDate.value),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      InkWell(
                        child: const Icon(Icons.expand_more),
                        onTap: () {},
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 70,
                  child: PageView.builder(
                    controller: _taskListController.pageController,
                    itemCount: _taskListController.calendar.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, i) {
                      final calendar = _taskListController.calendar;
                      return SizedBox(
                        width: 30,
                        height: 30,
                        child: GestureDetector(
                          onTap: () =>
                              _taskListController.changeValue(index: i),
                          child: Column(
                            children: [
                              Text(
                                DateFormat.E()
                                    .format(calendar[i])
                                    .substring(0, 1),
                                style: const TextStyle(
                                    color: Color(0xFF9A9A9A), fontSize: 14),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  DateFormat('d').format(calendar[i]),
                                  style: (selectedDate == calendar[i])
                                      ? DateLineFonts.t1
                                      : DateLineFonts().t2,
                                ),
                              ),
                              //circle container
                              Container(
                                width: 5,
                                height: 5,
                                decoration: const BoxDecoration(
                                  color: Palette.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }),
    );
  }
}
