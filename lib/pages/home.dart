import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../components/date_card.dart';
import '../size_config.dart';
import '../theme.dart';

import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  List<PendingNotificationRequest> _selectedNotifications = [];


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
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        toolbarHeight: 80,
        //title: const Text('CALENDER', style: TextStyle(fontWeight: FontWeight.bold, color: MyColors.black26, fontSize: 16),),
        actions: [
          IconButton(
              onPressed:(){
                //showAddBottomSheet(context);
                Navigator.pushNamed(context, '/add_notification');
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
        backgroundColor: Colors.grey.shade100,
        iconTheme: const IconThemeData(
          color: MyColors.black26,
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(15),
                vertical: getProportionateScreenHeight(15)),
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
                    color: MyColors.red, shape: BoxShape.circle),
                todayDecoration: BoxDecoration(
                    color:  MyColors.red.withOpacity(0.5),
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
          Expanded(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(25),
                    vertical: getProportionateScreenHeight(15)),
                decoration:  const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 3.0,
                      offset: Offset(0, 2),
                    ),
                  ],

                ),
                child: ListView(
                  children: [
                    Center(
                      child: Container(
                        height: 6,
                        width: 50,
                        decoration:  BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: const BorderRadius.all(Radius.circular(3)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    DateCard(selectedDay: _selectedDay),
                    const SizedBox(height: 16),
                  ],
                )
            ),
          )
        ],
      ),
    );
  }
}