import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../theme.dart';

class DateCard extends StatelessWidget {
  const DateCard({Key? key,this.selectedDay}): super(key: key);

  final DateTime? selectedDay;

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${selectedDay!.day< 10? '0': ''}${selectedDay!.day} ${DateFormat('MMM').format(selectedDay!)}.',
          style: const TextStyle(
            fontSize: 18,
            letterSpacing: 2,
            fontWeight: FontWeight.w500
          ),
        ),
        Text(
          DateFormat('EEEE').format(selectedDay!).toUpperCase(),
          style: const TextStyle(
              fontSize: 18,
              letterSpacing: 2,
              color: MyColors.red,
              fontWeight: FontWeight.bold
          ),
        ),
      ],
    );
  }
}

