import 'package:flutter/material.dart';
import 'package:budget_buddy/resources/app_export.dart';

class CategoryIcon extends StatelessWidget {
  final String imagePath;
  const CategoryIcon({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(360)),
      child: imagePath == ""
          ? const SizedBox()
          : Center(
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
