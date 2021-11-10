import 'package:intl/intl.dart';

class TimeUtils {
  final daysInWeek = 7;
  static List<String> days = DateFormat.EEEE().dateSymbols.STANDALONEWEEKDAYS;

  static List<String> getDays(int start, int end) =>
      days.sublist(start, end + 1);

  static String todayName() => DateFormat('EEEE').format(DateTime.now());

  static String to12HourClock(int hour) {
    if (hour == 12) {
      return '12pm';
    } else {
      return '${hour % 12}${hour < 12 ? 'am' : 'pm'}';
    }
  }
}
