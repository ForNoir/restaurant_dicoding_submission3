import 'package:intl/intl.dart';

class DateTimeHelper {
  static DateTime format() {
    // Format of Date and Time
    final now = DateTime.now();
    final dateFormat = DateFormat('d/M/y');
    const timeSpecific = "11:00:00";
    final completeFormat = DateFormat('d/M/y H:m:s');

    // Format Today
    final todayDate = dateFormat.format(now);
    final todayDateAndTime = "$todayDate $timeSpecific";
    var resultToday = completeFormat.parseStrict(todayDateAndTime);

    // Format Tomorrow
    var formatted = resultToday.add(const Duration(days: 1));
    final tomorrowDate = dateFormat.format(formatted);
    final tomorrowDateAndTime = "$tomorrowDate $timeSpecific";
    var resultTomorrow = completeFormat.parseStrict(tomorrowDateAndTime);

    return now.isAfter(resultToday) ? resultTomorrow : resultToday;
  }
}
