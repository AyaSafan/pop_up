import 'package:intl/intl.dart';

String getWeekdayNames(List<int> dayNumbers) {
  List<String> weekdayNames = [];
  DateFormat format = DateFormat('EEEE'); // 'EEEE' format returns the full weekday name

  for (int dayNumber in dayNumbers) {
    if (dayNumber >= 1 && dayNumber <= 7) {
      DateTime date = DateTime.utc(2023, 1, dayNumber); // Use any arbitrary year and month
      String weekdayName = format.format(date);
      weekdayNames.add(weekdayName);
    } else {
      weekdayNames.add('Invalid Day');
    }
  }

  return weekdayNames.join(', ');
}
