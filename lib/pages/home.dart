import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../components/date_card.dart';
import '../main.dart';
import '../size_config.dart';
import '../theme.dart';

import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../util.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  List<PendingNotificationRequest> _pendingNotifications = [];
  List<PendingNotificationRequest> _selectedNotifications = [];

  Future<void> getPendingNotificationRequests() async {
    print('-------------Get Pending Notifications ------------------');
    _pendingNotifications = await flutterLocalNotificationsPlugin.pendingNotificationRequests();
  }

  void getSelectedNotificationRequests() {

    print('********************* Get Selected Notifications *********************');
    _selectedNotifications = [];
    for (PendingNotificationRequest notification in _pendingNotifications){
      Map<String, dynamic> payload = jsonDecode(notification.payload!);
      DateTime payloadDateTime = DateFormat('yyyy-MM-dd – kk:mm').parse(payload["formattedDate"]);
        switch(payload["repeat"]) {
        //Once
          case 1:
            if(isSameFullDay(payloadDateTime, _selectedDay)){
              _selectedNotifications.add(notification);
            }
            break;
        //Weekly
          case 2:
            if(isSameWeekday(payloadDateTime, _selectedDay)){
              _selectedNotifications.add(notification);
            }
            break;
        //Daily
          case 3:
            _selectedNotifications.add(notification);
            break;
        //Yearly
          case 4:
            if(isSameDayAndMonth(payloadDateTime, _selectedDay)){
              _selectedNotifications.add(notification);
            }
        }

      }

    }


  @override
  void initState() {
    super.initState();
    getPendingNotificationRequests().then((value) => getSelectedNotificationRequests());

  }


  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _focusedDay = focusedDay;
        _selectedDay = selectedDay;
        _selectedNotifications = [];
        getSelectedNotificationRequests();
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    // You have to call it on your starting screen
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(60)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.mark_chat_unread_outlined, color: MyColors.red, size: 45),
                InkWell(
                    onTap: ()async{
                     await Navigator.pushNamed(context, '/add_notification');
                      // When the page is popped, this code will be executed
                      // You can refresh the current page here if needed
                      setState(() {
                        getPendingNotificationRequests().then((value) => getSelectedNotificationRequests());
                      });

                      },
                    child: const Text('+ NEW POP UP', style: TextStyle(color: MyColors.red, fontSize: 14, ),)
                )
              ],
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          /*AppBar(
            toolbarHeight: 70,
            title: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
                  child: const Icon(Icons.mark_chat_unread_outlined, color: MyColors.red, size: 45),
                ),
                Text('+ NEW \nPOP UP', style: TextStyle(color: MyColors.red, fontSize: 14, ),)
              ],
            ),
            /*actions: [
              IconButton(
                  onPressed:(){
                    //showAddBottomSheet(context);
                    Navigator.pushNamed(context, '/add_notification');
                  },
                  icon: const Icon(
                      Icons.add,
                      color: MyColors.red,
                      size: 30
                  )
              ),
              const SizedBox(width: 8,)
            ],*/
            elevation: 0.0,
            backgroundColor: Colors.grey.shade100,
            iconTheme: const IconThemeData(
              color: MyColors.black26,
            ),
          ),*/
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    const SizedBox(height: 8),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _selectedNotifications.length,
                        itemBuilder: (BuildContext context, int index) {
                          final notification = _selectedNotifications[index];

                          return Text(notification.payload!);
                        },
                      ),
                    )
                  ],
                )
            ),
          )
        ],
      ),
    );
  }
}