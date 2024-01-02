import 'package:budget_buddy/data_sources/category_model.dart';
import 'package:budget_buddy/resources/widget/small_category_icon.dart';
import 'package:flutter/material.dart';
import 'package:budget_buddy/resources/app_export.dart';

class HomeCategoryItem extends StatefulWidget {
  MyCategory category;
  HomeCategoryItem({super.key, required this.category});

  @override
  State<HomeCategoryItem> createState() => _HomeCategoryItemState();
}

class _HomeCategoryItemState extends State<HomeCategoryItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 37.v,
        child: Row(children: [
          SmallCategoryIcon(imagePath: widget.category.cImagePath),
          SizedBox(
            width: 9.h,
          ),
          Text(
            widget.category.cName,
            style: TextStyle(fontSize: 14.fSize, fontWeight: FontWeight.w500),
          ),
        ]));
  }
}
