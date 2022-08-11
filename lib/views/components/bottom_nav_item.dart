import 'package:flutter/material.dart';

class BottomNavItem extends StatelessWidget {
  final bool isSelected;
  final int number;
  const BottomNavItem({
    Key? key,
    required this.isSelected,
    required this.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          getIconData(number),
        ),
        Text(
          'Screen ${number}',
          style:
              isSelected ? TextStyle(fontWeight: FontWeight.bold) : TextStyle(),
        ),
      ],
    );
  }

  IconData getIconData(int num) {
    switch (num) {
      case 1:
        return isSelected ? Icons.looks_one : Icons.looks_one_outlined;
      case 2:
        return isSelected ? Icons.looks_two : Icons.looks_two_outlined;
      case 3:
        return isSelected ? Icons.looks_3 : Icons.looks_3_outlined;
      default:
        return isSelected ? Icons.looks_4 : Icons.looks_4_outlined;
    }
  }
}