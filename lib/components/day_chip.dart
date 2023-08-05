import 'package:flutter/material.dart';

import '../theme.dart';

class DayChip extends StatelessWidget {
  const DayChip({Key? key,
    this.label ='',
    this.selected = false,
    this.onSelected,
    this.color = MyColors.blue,
    this.backgroundColor = MyColors.lightBlue
  }) : super(key: key);

  final String label;
  final bool selected;
  final void Function(bool)? onSelected;
  final Color color;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(60.0), ),
      label: SizedBox(
          height: 30,
          width: 30,
          child: Center(child: Text(label, style: TextStyle(color: selected? color : Colors.grey.shade700),))
      ),
      labelPadding: const EdgeInsets.all(2),
      selected: selected,
      onSelected: onSelected,
      selectedColor: backgroundColor,
      backgroundColor: Colors.grey.shade200,
      elevation: 1,
      showCheckmark: false,
    );

  }
}
