import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../size_config.dart';
import '../theme.dart';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {

    // You have to call it on your starting screen
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        title: const Text('CALENDER', style: TextStyle(fontWeight: FontWeight.bold, color: MyColors.black26, fontSize: 16),),
        actions: [
          IconButton(
              onPressed:(){
                //showAddBottomSheet(context);
              },
              icon: const Icon(
                  Icons.add,
                  color: MyColors.black26,
                  size: 24
              )
          ),
          const SizedBox(width: 8,)
        ],
        elevation: 0.0,
        backgroundColor: MyColors.lilac,
        iconTheme: const IconThemeData(
          color: MyColors.black26,
        ),
      ),
      body: TableCalendar(
        startingDayOfWeek: StartingDayOfWeek.sunday,
        firstDay: DateTime(2023, 1, 1),
        lastDay: DateTime(2073, 1, 1),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) {
          // Use `selectedDayPredicate` to determine which day is currently selected.
          // If this returns true, then `day` will be marked as selected.

          // Using `isSameDay` is recommended to disregard
          // the time-part of compared DateTime objects.
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            // Call `setState()` when updating the selected day
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          }
        },
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            // Call `setState()` when updating calendar format
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay) {
          // No need to call `setState()` here
          _focusedDay = focusedDay;
        },
      ),
    );
  }
}