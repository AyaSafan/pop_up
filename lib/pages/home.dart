import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../size_config.dart';
import '../theme.dart';

import 'package:intl/intl.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;


  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _focusedDay = focusedDay;
        _selectedDay = selectedDay;
      });
    }
  }

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
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(getProportionateScreenWidth(15),getProportionateScreenHeight(8),
                getProportionateScreenWidth(15),getProportionateScreenHeight(25)),
            decoration:  BoxDecoration(
              color: MyColors.lilac ,
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(25)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 3.0,
                  color: Colors.grey.shade400,
                  offset: const Offset(0, 2),
                ),
              ],

            ),
            child: TableCalendar(
              startingDayOfWeek: StartingDayOfWeek.sunday,
              firstDay: DateTime(2021, 1, 1),
              lastDay: DateTime(2071, 1, 1),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              headerStyle: const HeaderStyle(
                leftChevronPadding:  EdgeInsets.all(0),
                rightChevronPadding:  EdgeInsets.all(0),
                headerPadding: EdgeInsets.fromLTRB(0,0,0,16),
              ),
              availableCalendarFormats: const {
                CalendarFormat.month: 'Month',
                CalendarFormat.week: 'Week'
              },
              daysOfWeekStyle: DaysOfWeekStyle(
                dowTextFormatter: (date, locale) {
                  return DateFormat.E(locale)
                      .format(date)
                      .substring(0, 2);
                  //.toUpperCase();
                },
              ),
              daysOfWeekHeight: 18,
              calendarStyle: CalendarStyle(
                selectedDecoration: const BoxDecoration(
                    color: Colors.deepPurple, shape: BoxShape.circle),
                todayDecoration: BoxDecoration(
                    color: Colors.deepPurple.withOpacity(0.5),
                    shape: BoxShape.circle),
              ),

              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: _onDaySelected,
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
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
          ),
        ],
      ),
    );
  }
}