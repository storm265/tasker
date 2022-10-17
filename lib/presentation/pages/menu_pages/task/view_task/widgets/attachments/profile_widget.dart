import 'package:easy_localization/easy_localization.dart';
import 'package:todo2/generated/locale_keys.g.dart';

String getDaysAgo(
  int daysAgo,
  int hoursAgo,
) {
  switch (daysAgo) {
    case 0:
      return '$hoursAgo ${hoursAgo >= 0 && hoursAgo <= 1 ? 'hour' : 'hours'} ago';
    case 1:
      return '$daysAgo ${LocaleKeys.day_ago.tr()}';
    default:
      return '$daysAgo ${LocaleKeys.days_ago.tr()}';
  }
}
