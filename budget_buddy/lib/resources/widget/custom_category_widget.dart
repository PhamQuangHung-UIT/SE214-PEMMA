import 'dart:ffi';

import 'package:budget_buddy/resources/app_export.dart';
import 'package:flutter/material.dart';
class CustomCategoryWidget extends StatelessWidget {
  final String CategoryName;
  final String ImagePath;
  final bool IsIncome;
  CustomCategoryWidget({required this.CategoryName, required this.ImagePath, required this.IsIncome});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.5),
        color: Colors.transparent
      ),
      height: 60,
      child: Row(
        children: [
          SizedBox(width: 10),
          ImageIcon(
            AssetImage('assets/images/minus.png'),
            color: Colors.green,
            size: 15,
          ),
          SizedBox(width: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(width: 1)
            ),
            padding: EdgeInsets.all(7),
            child: ImageIcon(
              AssetImage(ImagePath),
              color: Colors.black,
              size: 20,
            ),
          ),
          SizedBox(width: 10),
          Text(CategoryName),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              widthFactor: 50,
              child: ImageIcon(
                AssetImage('assets/images/pen.png'),
                color: Colors.black,
                size: 10,
              ),
            ),
          ),
          SizedBox(width: 20)
        ],
      ),
    );
  }
}
