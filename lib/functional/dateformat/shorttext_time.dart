
import 'package:intl/intl.dart';

extension ShortText on DateTime {

  String get shortText {
    final deltaDays = this.deltaCalenderDayFormNow;
    if (deltaDays == 0) {
      return '今天';
    } else if (deltaDays == -1) {
      return '昨天';
    } else if (deltaDays == -2) {
      return '前天';
    } else if (deltaDays > -7) {
      return '7 天内';
    } else if (deltaDays > -30) {
      return '30 天内';
    } else {
      return DateFormat.yMMMMd().format(this);
    }
  }

  int get deltaCalenderDayFormNow {
    final now = DateTime.now();
    return DateTime(this.year, this.month, this.day)
      .difference(DateTime(now.year, now.month, now.day))
      .inDays;
  }
}
