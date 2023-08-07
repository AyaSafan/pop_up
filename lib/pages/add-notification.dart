import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pop_up/size_config.dart';

import '../components/day_chip.dart';
import '../local_notifications.dart';
import '../theme.dart';
import '../util.dart';

class AddNotificationPage extends StatefulWidget {
  const AddNotificationPage({super.key});

  @override
  State<AddNotificationPage> createState() => _AddNotificationPageState();
}

class _AddNotificationPageState extends State<AddNotificationPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String label = '';

  final today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  List<TimeOfDay> times = [TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute + 1)];
  DateTime _selectedDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  List<int> days = [1,2,3,4,5,6,7];

  // 1: Once, 2:Weekly, 3: Daily, 4: Yearly
  int? selectedRadio = 1;
  void _handleRadioValueChanged(int? value) {
    setState(() {
      selectedRadio = value;
      _selectedDate = today;
    });
  }


  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute + 1),
    );
    if (newTime != null) {
      setState(() {
        times.add(newTime);
      });
    }
  }

  void _selectStartDate() async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2023, 1),
      lastDate: DateTime.now().add(const Duration(days: 7300)),
      helpText: 'Select start date',
    );
    if (newDate != null) {
      setState(() {
        _selectedDate = newDate;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 80,
          centerTitle: true,
          title: const Text('NEW POPUP', style: TextStyle(fontWeight: FontWeight.bold, color: MyColors.black26, fontSize: 16),),
          leading:  IconButton(
              onPressed: Navigator.of(context).pop,
              icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 18
              )
          ),
          actions: [
            IconButton(
                onPressed: (){
                  _formKey.currentState!.save();
                  pushNotifications().then((value) => Navigator.pop(context));
                },
                icon: const Icon(
                    Icons.done,
                    color: Colors.black,
                    size: 24
                )
            ),
          ],
          elevation: 0.0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
            color: MyColors.black26,
          ),
        ),
        body:
        Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: getProportionateScreenWidth(20)),
            child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    const SizedBox(height: 8,),
                    //TODO: Empty label resolve
                    TextFormField(
                      cursorColor: MyColors.black26 ,
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFf3f3f3),
                          floatingLabelStyle: TextStyle(color: MyColors.black26),
                          contentPadding: EdgeInsets.fromLTRB(15, 20, 30, 20),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                              borderSide: BorderSide(color:Color(0xFFf3f3f3)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(color: MyColors.black26),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(color: MyColors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(color: MyColors.red),
                          ),

                          labelText: 'Label',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a number';
                        }
                        return null;
                      },
                      onSaved: (value){setState(() {
                        label = value!;
                      });},
                    ),
                    const SizedBox(height: 16,),
                    InkWell(
                      onTap: _selectTime,
                      child: Container(
                        height: 60,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                            color: const Color(0xFFf3f3f3) ,
                            borderRadius: const BorderRadius.all(Radius.circular(8)),
                            border: Border.all(color: const Color(0xFFf3f3f3))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text ('Time', style: TextStyle(color: Colors.grey.shade700, fontSize: 16),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.add, size: 20, color: Colors.grey.shade700,)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    times.isEmpty? const Padding(
                      padding: EdgeInsets.fromLTRB(8,8,0,0),
                      child:  Text('Add times for reminder', style: TextStyle(color: Colors.red, fontSize: 12),),
                    )
                        : const SizedBox(),
                    const SizedBox(height: 16,),
                    Column(
                      children: times.asMap().entries.map<Widget>((time) {
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                          horizontalTitleGap: 0,
                          visualDensity:  const VisualDensity(horizontal: 0, vertical: -4),
                          title: Text(time.value.format(context).padLeft(8,"0"),
                            style: const TextStyle(color: MyColors.black26, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1), )
                          ,
                          //leading: const Icon(Icons.alarm),
                          leading: IconButton(onPressed: () {
                            setState(() {
                              times.removeAt(time.key);
                            });
                          }, icon: const Icon(Icons.remove_circle_outline),),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16,),
                    const Text(' Repeat', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.4,
                          child: ListTile(
                            title: const Text('Once'),
                            contentPadding: const EdgeInsets.all(0),
                            visualDensity:  const VisualDensity(horizontal: 0, vertical: VisualDensity.minimumDensity),
                            leading: Radio(
                              value: 1,
                              groupValue: selectedRadio,
                              onChanged: _handleRadioValueChanged,
                              activeColor: MyColors.red,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.4,
                          child: ListTile(
                            title: const Text('Weekly'),
                            contentPadding: const EdgeInsets.all(0),
                            visualDensity:  const VisualDensity(horizontal: 0, vertical: VisualDensity.minimumDensity),
                            leading: Radio(
                              value: 2,
                              groupValue: selectedRadio,
                              onChanged: _handleRadioValueChanged,
                              activeColor: MyColors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.4,
                          child: ListTile(
                            title: const Text('Daily'),
                            contentPadding: const EdgeInsets.all(0),
                            visualDensity: const VisualDensity(horizontal: 0, vertical: VisualDensity.minimumDensity),
                            leading: Radio(
                              value: 3,
                              groupValue: selectedRadio,
                              onChanged: _handleRadioValueChanged,
                              activeColor: MyColors.red,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.4,
                          child: ListTile(
                            title: const Text('Yearly'),
                            contentPadding: const EdgeInsets.all(0),
                            visualDensity:  const VisualDensity(horizontal: 0, vertical: VisualDensity.minimumDensity),
                            leading: Radio(
                              value: 4,
                              groupValue: selectedRadio,
                              onChanged: _handleRadioValueChanged,
                              activeColor: MyColors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16,),
                    selectedRadio != 1 && selectedRadio != 4 ? const SizedBox():
                    InkWell(
                      onTap: _selectStartDate,
                      child: Container(
                        height: 60,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                            color: const Color(0xFFf3f3f3) ,
                            borderRadius: const BorderRadius.all(Radius.circular(8)),
                            border: Border.all(color: const Color(0xFFf3f3f3))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text ('Date', style: TextStyle(color: Colors.grey.shade700, fontSize: 16),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(_selectedDate.isAtSameMomentAs(today)? 'Today ': DateFormat('d MMM y').format(_selectedDate)
                                    , style: TextStyle(color: Colors.grey.shade700, fontSize: 16)),
                                const SizedBox(width: 4,),
                                Icon(Icons.today, size: 20, color: Colors.grey.shade700,)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    selectedRadio != 2 ? const SizedBox():
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(' Schedule', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
                        const SizedBox(height: 8,),
                        Center(
                          child: Wrap(
                            runSpacing: 1,
                            spacing: 2,
                            children: [
                              DayChip(
                                label: 'Su',
                                selected: days.contains(DateTime.sunday) ? true : false,
                                onSelected: (bool value) {
                                  value
                                      ?  setState(() {
                                    days.add(DateTime.sunday);
                                  })
                                      : setState((){
                                    days.remove(DateTime.sunday);
                                  });
                                },
                              ),
                              DayChip(
                                label: 'Mo',
                                selected: days.contains(DateTime.monday) ? true : false,
                                onSelected: (bool value) {
                                  value
                                      ?  setState(() {
                                    days.add(DateTime.monday);
                                  })
                                      : setState((){
                                    days.remove(DateTime.monday);
                                  });
                                },
                              ),
                              DayChip(
                                label: 'Tu',
                                selected: days.contains(DateTime.tuesday) ? true : false,
                                onSelected: (bool value) {
                                  value
                                      ?  setState(() {
                                    days.add(DateTime.tuesday);
                                  })
                                      : setState((){
                                    days.remove(DateTime.tuesday);
                                  });
                                },
                              ),
                              DayChip(
                                label: 'We',
                                selected:
                                days.contains(DateTime.wednesday) ? true : false,
                                onSelected: (bool value) {
                                  value
                                      ?  setState(() {
                                    days.add(DateTime.wednesday);
                                  })
                                      : setState((){
                                    days.remove(DateTime.wednesday);
                                  });
                                },
                              ),
                              DayChip(
                                label: 'Th',
                                selected: days.contains(DateTime.thursday) ? true : false,
                                onSelected: (bool value) {
                                  value
                                      ?  setState(() {
                                    days.add(DateTime.thursday);
                                  })
                                      : setState((){
                                    days.remove(DateTime.thursday);
                                  });
                                },
                              ),
                              DayChip(
                                label: 'Fr',
                                selected: days.contains(DateTime.friday) ? true : false,
                                onSelected: (bool value) {
                                  value
                                      ?  setState(() {
                                    days.add(DateTime.friday);
                                  })
                                      : setState((){
                                    days.remove(DateTime.friday);
                                  });
                                },
                              ),
                              DayChip(
                                label: 'Sa',
                                selected: days.contains(DateTime.saturday) ? true : false,
                                onSelected: (bool value) {
                                  value
                                      ?  setState(() {
                                    days.add(DateTime.saturday);
                                  })
                                      : setState((){
                                    days.remove(DateTime.saturday);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )
            )
        )

    );
  }

  String getRepeatDescriptions(){
    String description ='';
    switch(selectedRadio) {
      case 1:
        description = 'Today Only';
        break;
      case 2:
        description = 'Every ${getWeekdayNames(days)}';
        break;
      case 3:
        description = 'Daily';
        break;
      case 4:
        description = 'Yearly';
    }
    return description;
  }

  int getUniqueId(){
    final now = DateTime.now();
    int timestamp = now.microsecondsSinceEpoch;
    int id = timestamp ~/ 1000000 + timestamp % 1000000;
    return id;
  }
  Future<void> pushNotifications() async{
    final now = DateTime.now();
    int timestamp = now.microsecondsSinceEpoch;
    String notificationGroupKey = timestamp.toString();

    for (var time in times){
      var dateTime = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day,
          time.hour, time.minute);

      String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(dateTime);

      Map<String, dynamic> payload = {
        'notificationGroupKey': notificationGroupKey,
        'formattedDate': formattedDate,
        'description': getRepeatDescriptions(),
        'repeat': selectedRadio
      };

      String jsonStringPayload = jsonEncode(payload);

      switch(selectedRadio) {
        //Once
        case 1:
          //only push notification if date+time is after NOW
          if (dateTime.isAfter(now)) {
            await onceNotification(getUniqueId(), label, dateTime, jsonStringPayload, notificationGroupKey);
          }
          break;
        //Weekly
        case 2:
          for (var day in days) {
            //Get next occurrence of day
            while (dateTime.weekday != day) {
              dateTime = dateTime.add(const Duration(days: 1));
            }

            formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(dateTime);

            payload = {
              'notificationGroupKey': notificationGroupKey,
              'formattedDate': formattedDate,
              'description': getRepeatDescriptions(),
              'repeat': selectedRadio
            };

            jsonStringPayload = jsonEncode(payload);

            await weeklyNotification(getUniqueId(), label, dateTime, jsonStringPayload, notificationGroupKey);

          }
          break;
        //Daily
        case 3:
          if (dateTime.isBefore(now)) {
            dateTime = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day+1,
                time.hour, time.minute);
          }

          formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(dateTime);

          payload = {
            'notificationGroupKey': notificationGroupKey,
            'formattedDate': formattedDate,
            'description': getRepeatDescriptions(),
            'repeat': selectedRadio
          };

          jsonStringPayload = jsonEncode(payload);

          await dailyNotification(getUniqueId(), label, dateTime, jsonStringPayload, notificationGroupKey);
          break;
        //Yearly
        case 4:
          if (dateTime.isBefore(now)) {
            dateTime = DateTime(_selectedDate.year+1, _selectedDate.month, _selectedDate.day,
                time.hour, time.minute);
          }
          
          formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(dateTime);

          payload = {
            'notificationGroupKey': notificationGroupKey,
            'formattedDate': formattedDate,
            'description': getRepeatDescriptions(),
            'repeat': selectedRadio
          };

          jsonStringPayload = jsonEncode(payload);

          await yearlyNotification(getUniqueId(), label, dateTime, jsonStringPayload, notificationGroupKey);
      }
    }
  }
}
