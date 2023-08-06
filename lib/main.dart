import 'package:flutter/material.dart';
import 'package:pop_up/pages/add-notification.dart';
import 'package:pop_up/pages/home.dart';
import 'package:pop_up/theme.dart';

void main() {
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

