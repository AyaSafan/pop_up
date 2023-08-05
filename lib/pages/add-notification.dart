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
  DateTime? _endDate;
  bool isRepeated = true;
  List<int> days = [1,2,3,4,5,6,7];
  String label = 'no label';

  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute + 1),
      builder: (context, child){
        return Theme(
          data: Theme.of(context).copyWith(
            primaryColor: MyColors.blue,
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: MyColors.blue,
              secondary: MyColors.lightBlue,
            ),
          ),
          child: child!,
        );
      },
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
      firstDate: DateTime(2020, 1),
      lastDate: DateTime.now().add(const Duration(days: 7300)),
      helpText: 'Select start date',
      builder: (context, child){
        return Theme(
          data: Theme.of(context).copyWith(
            primaryColor: MyColors.blue,
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: MyColors.blue,
              secondary: MyColors.lightBlue,
            ),
          ),
          child: child!,
        );
      },
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
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: getProportionateScreenWidth(10)),
            child: ListView(
              children: [
                Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16,),
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
                        const SizedBox(height: 32,),
                        const Text(' Duration', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                        ListTile(
                          title: const Text('Ongoing'),
                          contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
                          visualDensity:  const VisualDensity(horizontal: 0, vertical: VisualDensity.minimumDensity),
                          leading: Radio(
                            value: true,
                            groupValue: isRepeated,
                            onChanged: (value) {
                              setState(() {
                                isRepeated = true;
                                _endDate = null;
                              });
                            },
                            activeColor: MyColors.blue,
                          ),
                        ),
                        ListTile(
                          title: const Text('Number of days'),
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
                            TextFormField(
                              keyboardType: TextInputType.number,
                              cursorColor: MyColors.black26 ,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: const Color(0xFFf3f3f3),
                                  floatingLabelStyle: const TextStyle(color: MyColors.black26),
                                  contentPadding: const EdgeInsets.fromLTRB(15, 20, 30, 20),
                                  enabledBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                    borderSide: BorderSide(color: Color(0xFFf6f6f6)),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                    borderSide: BorderSide(color: MyColors.blue),
                                  ),
                                  errorBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                    borderSide: BorderSide(color: MyColors.red),
                                  ),
                                  focusedErrorBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                    borderSide: BorderSide(color: MyColors.red),
                                  ),

                                  labelText: 'Number of days',
                                  suffixIcon:  Icon(
                                    Icons.date_range, size: 20, color: Colors.grey.shade700,),
                                  suffixStyle: const TextStyle(color: MyColors.blue )
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty || value.isNotEmpty && int.tryParse(value).runtimeType != int) {
                                  return 'Please enter a number';
                                }
                                return null;
                              },
                              onSaved: (value){setState(() {
                                _endDate = _startDate.add(Duration(days: int.parse(value!)-1));
                              });},
                            ),
                            const SizedBox(height: 24,),
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
