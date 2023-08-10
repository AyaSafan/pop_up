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

bool isSameFullDay(DateTime dateTime1, DateTime dateTime2) {
  final date1 = DateTime(dateTime1.year, dateTime1.month, dateTime1.day);
  final date2 = DateTime(dateTime2.year, dateTime2.month, dateTime2.day);
  return date1.isAtSameMomentAs(date2);
}

bool isSameWeekday(DateTime dateTime1, DateTime dateTime2) {
  return dateTime1.weekday == dateTime2.weekday;
}

bool isSameDayAndMonth(DateTime dateTime1, DateTime dateTime2) {
  return dateTime1.day == dateTime2.day && dateTime1.month == dateTime2.month;
}


String formatTime(String formattedDate) {
  DateTime dateTime = DateFormat('yyyy-MM-dd – kk:mm').parse(formattedDate);
  String formattedTime = DateFormat('hh:mm a').format(dateTime);
  return formattedTime;
}





