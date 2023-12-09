import 'package:flutter/material.dart';
import 'package:budget_buddy/resources/app_export.dart';

class GoalIcon extends StatelessWidget {
  final String imagePath;
  const GoalIcon({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(360)),
      child: Center(
          child: SizedBox(
              child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
        width: 30.adaptSize,
        height: 30.adaptSize,
      ))),
    );
  }
}
