import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';

class TaskListController extends ChangeNotifier {
  ValueNotifier<DateTime> selectedDate = ValueNotifier(DateTime.now());

  final pageController = PageController(viewportFraction: 0.18);
  List<DateTime> calendar = [];

  void generateCalendar() {
    calendar = List.generate(
        120, // 120 days = 100 days before now and 20 after now
        (index) => DateTime.parse(DateTime.utc(DateTime.now().year,
                DateTime.now().month, DateTime.now().day - 100 + index)
            .toString()));
  }

  void changeValue({required int index}) {
    selectedDate.value = calendar[index];

    findIndexThenScroll();
    selectedDate.notifyListeners();
  }

  void updateCalendar(Function update) {
    pageController.addListener(() {
      generateLastCalendarElements();
      update();
      generateFirstCalendarElements();
      update();
    });
  }

  void findIndexThenScroll() {
    for (int i = 0; i < calendar.length; i++) {
      String selectedDayString = selectedDate.value.toString().substring(0, 11);
      String calendarList = calendar[i].toString().substring(0, 11);
      if (selectedDayString.compareTo(calendarList) == 0) {
        selectedDate.value = calendar[i];
        _scrollToElement(i);
        notifyListeners();
        break;
      }
    }
  }

  void _scrollToElement(int index) {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await pageController.animateToPage(index,
          duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
    });
  }

  void generateFirstCalendarElements() {
    // start of the page
    if (pageController.position.minScrollExtent ==
        pageController.position.pixels) {
      var firstElement = calendar.first;

      List<DateTime> first = List.generate(
          20,
          (index) => DateTime.parse(DateTime.utc(firstElement.year,
                  firstElement.month, firstElement.day - index)
              .toString()));

      calendar.insertAll(0, first);
    }
  }

  void generateLastCalendarElements() {
    // end of the page
    if (pageController.position.maxScrollExtent ==
        pageController.position.pixels) {
      var lastElement = calendar.last;

      List<DateTime> last = List.generate(
          20,
          (index) => DateTime.parse(DateTime.utc(lastElement.year,
                  lastElement.month, lastElement.day + 1 + index)
              .toString()));

      calendar.addAll(last);
    }
  }
}
