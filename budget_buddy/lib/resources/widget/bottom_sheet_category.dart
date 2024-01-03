import 'package:budget_buddy/data_sources/category_model.dart';
import 'package:budget_buddy/resources/widget/category_icon.dart';
import 'package:flutter/material.dart';
import 'package:budget_buddy/resources/app_export.dart';

class BottomSheetCategory extends StatefulWidget {
  MyCategory category;
  bool isSelected;
  final VoidCallback onTap;
  BottomSheetCategory(
      {super.key,
      required this.category,
      required this.isSelected,
      required this.onTap});

  @override
  State<BottomSheetCategory> createState() => _BottomSheetCategoryState();
}

class _BottomSheetCategoryState extends State<BottomSheetCategory> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 23.h),
        height: 49.v,
        child: Row(children: [
          CategoryIcon(imagePath: widget.category.cImagePath),
          SizedBox(
            width: 13.h,
          ),
          Text(
            widget.category.cName,
            style: TextStyle(fontSize: 20),
          ),
          Spacer(),
          SizedBox(
            height: 31.v,
            width: 31.h,
            child: widget.isSelected == true
                ? Image.asset('assets/images/check_2.png')
                : SizedBox(),
          )
        ]),
      ),
    );
  }
}
