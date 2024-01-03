import 'package:flutter/material.dart';
import 'package:budget_buddy/resources/app_export.dart';

class SmallCategoryIcon extends StatelessWidget {
  final String imagePath;
  SmallCategoryIcon({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.adaptSize,
      width: 35.adaptSize,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(360)),
      child: imagePath == ""
          ? SizedBox()
          : Center(
              child: SizedBox(
                  child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: 20.adaptSize,
              height: 20.adaptSize,
            ))),
    );
  }
}
