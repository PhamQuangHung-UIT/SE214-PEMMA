import 'package:budget_buddy/models/budget_model.dart';
import 'package:budget_buddy/resources/widget/category_icon.dart';
import 'package:flutter/material.dart';
import 'package:budget_buddy/resources/app_export.dart';
import 'package:intl/intl.dart';

class BudgetTile extends StatefulWidget {
  Budget budget;
  BudgetTile({super.key, required this.budget});

  @override
  State<BudgetTile> createState() => _BudgetTileState();
}

class _BudgetTileState extends State<BudgetTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0.h, 0.v, 9.h, 15.v),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CategoryIcon(imagePath: widget.budget.imagePath),
        Center(
          child: Container(
            width: 186.h,
            margin: EdgeInsets.fromLTRB(0.h, 12.v, 0.h, 0.v),
            child: Text(
              widget.budget.categoryName,
              style: TextStyle(
                fontSize: 20.fSize,
                fontWeight: FontWeight.w400,
                height: 1.2175.v,
                color: Color(0xff000000),
              ),
            ),
          ),
        ),
        Spacer(),
        Container(
            margin: EdgeInsets.fromLTRB(0.h, 10.v, 0.h, 0.v),
            child: SizedBox(
                child: Image.asset(
              "assets/images/plus.png",
              fit: BoxFit.cover,
              width: 26.adaptSize,
              height: 26.adaptSize,
            )))
      ]),
    );
  }
}
