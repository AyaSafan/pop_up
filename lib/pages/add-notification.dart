import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pop_up/size_config.dart';

import '../components/day_chip.dart';
import '../theme.dart';

class AddNotificationPage extends StatefulWidget {
  const AddNotificationPage({super.key});

  @override
  State<AddNotificationPage> createState() => _AddNotificationPageState();
}

class _AddNotificationPageState extends State<AddNotificationPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  List<TimeOfDay> times = [TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute + 1)];
  DateTime _startDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime _endDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).add(const Duration(days: 1));
  bool isRepeated = false;
  List<int> days = [1,2,3,4,5,6,7];
  String label = 'no label';

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
      initialDate: _startDate,
      firstDate: DateTime(2023, 1),
      lastDate: DateTime.now().add(const Duration(days: 7300)),
      helpText: 'Select start date',
    );
    if (newDate != null) {
      setState(() {
        _startDate = newDate;
      });
    }
  }

  void _selectEndDate() async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: _endDate,
      firstDate: DateTime(2023, 1),
      lastDate: DateTime.now().add(const Duration(days: 7300)),
      helpText: 'Select End date',
    );
    if (newDate != null) {
      setState(() {
        _startDate = newDate;
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
          elevation: 0.0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
            color: MyColors.black26,
          ),
        ),
        body:
        Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: getProportionateScreenWidth(20)),
            child: ListView(
              children: [
                Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16,),
                        InkWell(
                          onTap: _selectStartDate,
                          child: Container(
                            height: 60,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                                color: const Color(0xFFf3f3f3) ,
                                borderRadius: const BorderRadius.all(Radius.circular(8)),
                                //border: Border.all(color: const Color(0xFFe6e6e6))
                                border: Border.all(color: const Color(0xFFf3f3f3))
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text ('Start Date', style: TextStyle(color: Colors.grey.shade700, fontSize: 16),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(_startDate.isAtSameMomentAs(today)? 'Today ': DateFormat('d MMM y').format(_startDate)
                                        , style: TextStyle(color: Colors.grey.shade700, fontSize: 16)),
                                    const SizedBox(width: 4,),
                                    Icon(Icons.today, size: 20, color: Colors.grey.shade700,)
                                  ],
                                ),
                              ],
                            ),
                          ),
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
                                //border: Border.all(color: const Color(0xFFe6e6e6))
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
                                style: const TextStyle(color: MyColors.blue, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1), )
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
                        const Text(' Duration', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                        ListTile(
                          title: const Text('Once'),
                          contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
                          visualDensity: const VisualDensity(horizontal: 0, vertical: VisualDensity.minimumDensity),
                          leading: Radio(
                            value: false,
                            groupValue: isRepeated,
                            onChanged: (value) {
                              setState(() {
                                isRepeated = false;
                                _endDate = _startDate;
                              });
                            },
                            activeColor: MyColors.blue,
                          ),
                        ),
                        ListTile(
                          title: const Text('Repeat'),
                          contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
                          visualDensity:  const VisualDensity(horizontal: 0, vertical: VisualDensity.minimumDensity),
                          leading: Radio(
                            value: true,
                            groupValue: isRepeated,
                            onChanged: (value) {
                              setState(() {
                                isRepeated = true;
                              });
                            },
                            activeColor: MyColors.blue,
                          ),
                        ),
                        ListTile(
                          title: const Text('Customized'),
                          contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
                          visualDensity: const VisualDensity(horizontal: 0, vertical: VisualDensity.minimumDensity),
                          leading: Radio(
                            value: false,
                            groupValue: isRepeated,
                            onChanged: (value) {
                              setState(() {
                                isRepeated = false;
                                _endDate = _startDate;
                              });
                            },
                            activeColor: MyColors.blue,
                          ),
                        ),
                        const SizedBox(height: 16,),
                        isRepeated? const SizedBox(height: 16,):
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(' Schedule', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                            const SizedBox(height: 8,),
                            Center(
                              child: Wrap(
                                runSpacing: 1,
                                spacing: 2,
                                children: [
                                  DayChip(
                                    backgroundColor: MyColors.lightBlue,
                                    color: MyColors.blue,
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
                                    backgroundColor: MyColors.lightBlue,
                                    color: MyColors.blue,
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
                                    backgroundColor: MyColors.lightBlue,
                                    color: MyColors.blue,
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
                                    backgroundColor: MyColors.lightBlue,
                                    color: MyColors.blue,
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
                                    backgroundColor: MyColors.lightBlue,
                                    color: MyColors.blue,
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
                                    backgroundColor: MyColors.lightBlue,
                                    color: MyColors.blue,
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
                                    backgroundColor: MyColors.lightBlue,
                                    color: MyColors.blue,
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
                            const SizedBox(height: 16,),
                            InkWell(
                              onTap: _selectEndDate,
                              child: Container(
                                height: 60,
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                    color: const Color(0xFFf3f3f3) ,
                                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                                    //border: Border.all(color: const Color(0xFFe6e6e6))
                                    border: Border.all(color: const Color(0xFFf3f3f3))
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text ('End Date', style: TextStyle(color: Colors.grey.shade700, fontSize: 16),),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(DateFormat('d MMM y').format(_endDate)
                                            , style: TextStyle(color: Colors.grey.shade700, fontSize: 16)),
                                        const SizedBox(width: 4,),
                                        Icon(Icons.today, size: 20, color: Colors.grey.shade700,)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16,),

                          ],
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyColors.blue,
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              //onSubmit();
                            }
                          },
                          child: const Text('SAVE', style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                        const SizedBox(height: 24,),
                      ],
                    )
                )
              ],
            )
        )

    );
  }
}
