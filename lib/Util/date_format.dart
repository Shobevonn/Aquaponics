import 'package:intl/intl.dart' as inlt;

class DateFormat {
  DateTime? _date;

  final List<String> _monthName = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  final List<String> _monthShortName = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  DateFormat() {
    _date = DateTime.now();
  }

  DateFormat.withValue(DateTime value) {
    _date = value;
  }

  String dateToday() {
    int month = _date!.month;
    int day = _date!.day;
    int year = _date!.year;

    return '${_monthName[--month]} ${day.toString()}, ${year.toString()}';
  }

  String dateTodayShort() {
    int month = _date!.month;
    int day = _date!.day;
    int year = _date!.year;

    return '${_monthShortName[--month]} ${day.toString()}, ${year.toString()}';
  }

  String get monthOfToday => _monthName[_date!.month];

  String getDayOfWeek() {
    String day = '';
    switch (_date!.weekday) {
      case DateTime.monday:
        day = 'Monday';
        break;
      case DateTime.tuesday:
        day = 'Tuesday';
        break;
      case DateTime.wednesday:
        day = 'Wednesday';
        break;
      case DateTime.thursday:
        day = 'Thursday';
        break;
      case DateTime.friday:
        day = 'Friday';
        break;
      case DateTime.saturday:
        day = 'Saturday';
        break;
      case DateTime.sunday:
        day = 'Sunday';
        break;
    }
    return day;
  }

  String getTime() {
    DateTime now = _date!;
    String code = now.hour >= 12 ? 'PM' : 'AM';
    String formattedTime = "${now.hour}:${now.minute} $code";
    return formattedTime;
  }
}
