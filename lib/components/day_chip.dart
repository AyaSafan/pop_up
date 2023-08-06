import 'package:flutter/material.dart';
import 'package:pop_up/size_config.dart';

import '../theme.dart';

class DayChip extends StatelessWidget {
  const DayChip({Key? key,
    this.label ='',
    this.selected = false,
    this.onSelected,
    this.color = MyColors.red,
    this.backgroundColor = MyColors.lightRed
  }) : super(key: key);

  final String label;
  final bool selected;
  final void Function(bool)? onSelected;
  final Color color;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(getProportionateScreenWidth(30)),),
      label: SizedBox(
          height: getProportionateScreenWidth(30),
          width: getProportionateScreenWidth(30),
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
