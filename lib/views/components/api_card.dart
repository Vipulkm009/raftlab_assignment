import 'package:flutter/material.dart';

class APICard extends StatelessWidget {
  final IconData icon;
  final String title;
  const APICard({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InputChip(
      backgroundColor: Colors.black,
      disabledColor: Colors.black87,
      selectedColor: Colors.black87,
      isEnabled: false,
      selected: true,
      avatar: Icon(
        icon,
        size: 14.0,
        color: Colors.white,
      ),
      label: Text(
        title,
        style: TextStyle(
          fontSize: 14.0,
          color: Colors.white,
        ),
      ),
      labelStyle: TextStyle(
        fontSize: 14.0,
        color: Colors.white,
      ),
    );
  }
}
