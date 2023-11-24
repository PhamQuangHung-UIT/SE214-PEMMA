import 'package:budget_buddy/models/budget_model.dart';
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
        Container(
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
            widget.budget.imagePath,
            fit: BoxFit.cover,
            width: 30.adaptSize,
            height: 30.adaptSize,
          ))),
        ),
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
