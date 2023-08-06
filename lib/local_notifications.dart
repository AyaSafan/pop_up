
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pop_up/main.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/timezone.dart' as tz;

String currentTimezone = 'Unknown';


initializeNotifications() async {

  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  flutterLocalNotificationsPlugin.initialize(initializationSettings);
  currentTimezone = await FlutterTimezone.getLocalTimezone();
}



Future<void> onceNotification(
    int notificationId,
    String title,
    DateTime dateTime,
    String? payload,
    String? groupKey,) async {

  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'PopUp','PopUp',
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
    groupKey: groupKey,
  );
  var platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
  );

  var tzDateTime = tz.TZDateTime.from(dateTime, tz.getLocation(await FlutterTimezone.getLocalTimezone()),)
      .add(const Duration(seconds: 1));

  flutterLocalNotificationsPlugin.zonedSchedule(
      notificationId, title, null, tzDateTime, platformChannelSpecifics,
      payload: payload,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime
  );

  print('pushed Notification');
  _checkPendingNotificationRequests();

}

Future<void> dailyNotification(
    int notificationId,
    String title,
    DateTime dateTime,
    String? payload,
    String? groupKey,) async {

  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'PopUp','PopUp',
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
    groupKey: groupKey,
  );
  var platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
  );

  var tzDateTime = tz.TZDateTime.from(dateTime, tz.getLocation(await FlutterTimezone.getLocalTimezone()),)
      .add(const Duration(seconds: 1));

  flutterLocalNotificationsPlugin.zonedSchedule(
      notificationId, title, null, tzDateTime, platformChannelSpecifics,
      payload: payload,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time
  );
  print('pushed Notification');
  _checkPendingNotificationRequests();

}


Future<void> weeklyNotification(
    int notificationId,
    String title,
    DateTime dateTime,
    String? payload,
    String? groupKey,) async {

  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'PopUp','PopUp',
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
    groupKey: groupKey,
  );
  var platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
  );

  var tzDateTime = tz.TZDateTime.from(dateTime, tz.getLocation(await FlutterTimezone.getLocalTimezone()),)
      .add(const Duration(seconds: 1));

  flutterLocalNotificationsPlugin.zonedSchedule(
      notificationId, title, null, tzDateTime, platformChannelSpecifics,
      payload: payload,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime
  );
  print('pushed Notification');
  _checkPendingNotificationRequests();


}

Future<void> yearlyNotification(
    int notificationId,
    String title,
    DateTime dateTime,
    String? payload,
    String? groupKey,) async {

  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'PopUp','PopUp',
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
    groupKey: groupKey,
  );
  var platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
  );

  var tzDateTime = tz.TZDateTime.from(dateTime, tz.getLocation(await FlutterTimezone.getLocalTimezone()),)
      .add(const Duration(seconds: 1));

  flutterLocalNotificationsPlugin.zonedSchedule(
      notificationId, title, null, tzDateTime, platformChannelSpecifics,
      payload: payload,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dateAndTime
  );
  print('pushed Notification');
  _checkPendingNotificationRequests();

}


Future<void> cancelNotification(int id) async {
  await flutterLocalNotificationsPlugin.cancel(id);
}

Future<void> _checkPendingNotificationRequests() async {
  final List<PendingNotificationRequest> pendingNotificationRequests =
  await flutterLocalNotificationsPlugin.pendingNotificationRequests();
  for (final request  in pendingNotificationRequests) {
    print(request.title);
    print(request.payload);
  }
}