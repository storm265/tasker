import 'package:easy_localization/easy_localization.dart';
import 'package:todo2/generated/locale_keys.g.dart';

String getDaysAgo(
  int daysAgo,
  int hoursAgo,
) {
  switch (daysAgo) {
    case 0:
      return '$hoursAgo ${getHour(hoursAgo.toString())} ago';
    case 1:
      return '$daysAgo ${LocaleKeys.day_ago.tr()}';
    default:
      return '$daysAgo ${LocaleKeys.days_ago.tr()}';
  }
}

String getHour(String hour) {
  if (hour.contains('1')) {
    return 'hour';
  } else {
    return 'hours';
  }
}
