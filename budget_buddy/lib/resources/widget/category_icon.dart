import 'package:flutter/material.dart';
import 'package:budget_buddy/resources/app_export.dart';

class CategoryIcon extends StatelessWidget {
  final String imagePath;
  CategoryIcon({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0.h, 0.v, 13.h, 10.v),
      padding: EdgeInsets.fromLTRB(8.h, 7.v, 8.h, 7.v),
      height: 48.v,
      width: 48.h,
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
