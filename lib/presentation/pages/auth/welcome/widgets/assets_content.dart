import 'package:easy_localization/easy_localization.dart';
import 'package:todo2/generated/locale_keys.g.dart';

class Walkthrough1 {
  final String avatarsTitle = 'first';
  final String titleText = LocaleKeys.welcome_to_todoList.tr();
  final String subText = LocaleKeys.whats_going_to_happen_tomorrow.tr();
}

class Walkthrough2 {
  final String avatarsTitle = 'second';
  final String titleText = LocaleKeys.work_happens.tr();
  final String subText = LocaleKeys.get_notified_when_work_happens.tr();
}

class Walkthrough3 {
  final String avatarsTitle = 'third';
  final String titleText = LocaleKeys.tasks_and_assign.tr();
  final String subText = LocaleKeys.task_and_assign_them_to_colleagues.tr();
}
