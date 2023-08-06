import 'package:flutter/material.dart';
import 'package:pop_up/pages/add-notification.dart';
import 'package:pop_up/pages/home.dart';
import 'package:pop_up/theme.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> _configureLocalTimeZone() async {
  tz.initializeTimeZones();
  final String? timeZoneName = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName!));
}

Future<void> main() async{

  // needed if you intend to initialize in the `main` function
  WidgetsFlutterBinding.ensureInitialized();
  await _configureLocalTimeZone();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pop Up',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: myColorScheme,
        //useMaterial3: true,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => MyHomePage(),
        '/add_notification': (context) => AddNotificationPage(),
      },
    );
  }
}

