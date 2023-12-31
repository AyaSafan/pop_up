
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:pop_up/main.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/timezone.dart' as tz;

String currentTimezone = 'Unknown';


initializeNotifications() async {

  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_icon');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  flutterLocalNotificationsPlugin.initialize(initializationSettings);
  currentTimezone = await FlutterTimezone.getLocalTimezone();
}

var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
  'PopUp','PopUp',
  importance: Importance.max,
  priority: Priority.high,
  playSound: true,
);


Future<void> onceNotification(
    int notificationId,
    String title,
    String body,
    DateTime dateTime,
    String? payload) async {

  var platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
  );

  var tzDateTime = tz.TZDateTime.from(dateTime, tz.getLocation(await FlutterTimezone.getLocalTimezone()),)
      .add(const Duration(seconds: 1));

  flutterLocalNotificationsPlugin.zonedSchedule(
      notificationId, title, body, tzDateTime, platformChannelSpecifics,
      payload: payload,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime
  );
  print('************  created notification ${DateFormat('yyyy-MM-dd  HH:mm').format(dateTime)} ');
}

Future<void> dailyNotification(
    int notificationId,
    String title,
    String body,
    DateTime dateTime,
    String? payload) async {

  var platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
  );

  var tzDateTime = tz.TZDateTime.from(dateTime, tz.getLocation(await FlutterTimezone.getLocalTimezone()),)
      .add(const Duration(seconds: 1));

  flutterLocalNotificationsPlugin.zonedSchedule(
      notificationId, title, body, tzDateTime, platformChannelSpecifics,
      payload: payload,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time
  );
  print('************  created notification ${DateFormat('yyyy-MM-dd  HH:mm').format(dateTime)} ');
}


Future<void> weeklyNotification(
    int notificationId,
    String title,
    String body,
    DateTime dateTime,
    String? payload) async {

  var platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
  );

  var tzDateTime = tz.TZDateTime.from(dateTime, tz.getLocation(await FlutterTimezone.getLocalTimezone()),)
      .add(const Duration(seconds: 1));

  flutterLocalNotificationsPlugin.zonedSchedule(
      notificationId, title, body, tzDateTime, platformChannelSpecifics,
      payload: payload,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime
  );
  print('************  created notification ${DateFormat('yyyy-MM-dd  HH:mm').format(dateTime)} ');

}

Future<void> yearlyNotification(
    int notificationId,
    String title,
    String body,
    DateTime dateTime,
    String? payload) async {

  var platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
  );

  var tzDateTime = tz.TZDateTime.from(dateTime, tz.getLocation(await FlutterTimezone.getLocalTimezone()),)
      .add(const Duration(seconds: 1));

  flutterLocalNotificationsPlugin.zonedSchedule(
      notificationId, title, body, tzDateTime, platformChannelSpecifics,
      payload: payload,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dateAndTime
  );
  print('************  created notification ${DateFormat('yyyy-MM-dd  HH:mm').format(dateTime)} ');
}


Future<void> cancelNotification(int id) async {
  await flutterLocalNotificationsPlugin.cancel(id);
}

