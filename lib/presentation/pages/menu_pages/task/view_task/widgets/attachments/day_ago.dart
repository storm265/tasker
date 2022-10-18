import 'package:easy_localization/easy_localization.dart';
import 'package:todo2/generated/locale_keys.g.dart';

String getDaysAgo(
  int daysAgo,
  int hoursAgo,
) {
  switch (daysAgo) {
    case 0:
      if (hoursAgo.toString() == '0') {
        return 'recently';
      } else {
        return '$hoursAgo ${getHour(hoursAgo.toString())} ${LocaleKeys.ago.tr()}';
      }
    case 1:
      return '$daysAgo ${LocaleKeys.day.tr()} ${LocaleKeys.ago.tr()}';
    default:
      return '$daysAgo ${LocaleKeys.days.tr()} ${LocaleKeys.ago.tr()}';
  }
}

String getHour(String hour) {
  if (hour.contains('1')) {
    return 'hour';
  } else {
    return 'hours';
  }
}
