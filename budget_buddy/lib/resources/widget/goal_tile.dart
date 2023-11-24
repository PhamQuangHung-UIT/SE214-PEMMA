import 'package:budget_buddy/models/goal_model.dart';
import 'package:budget_buddy/resources/app_export.dart';
import 'package:budget_buddy/resources/widget/category_icon.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:intl/intl.dart';

class GoalTile extends StatefulWidget {
  Goal goal;
  GoalTile({super.key, required this.goal});
  @override
  State<GoalTile> createState() => _GoalTileState();
}

class _GoalTileState extends State<GoalTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0.h, 0.v, 0.h, 10.v),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CategoryIcon(imagePath: widget.goal.imagePath),
          Container(
            margin: EdgeInsets.fromLTRB(0.h, 3.v, 0.h, 0.v),
            width: 272.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0.h, 0.v, 0.h, 12.v),
                  child: Text(
                    widget.goal.name,
                    style: TextStyle(
                      fontSize: 18.fSize,
                      fontWeight: FontWeight.w500,
                      height: 1.2175.v,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0.h, 0.v, 1.h, 5.v),
                  width: 270.h,
                  height: 4.v,
                  child: LinearPercentIndicator(
                    width: 270.h,
                    percent: widget.goal.fundedAmount / widget.goal.price,
                    backgroundColor: Color(0xffB7B7B7),
                    animation: true,
                    animationDuration: 1000,
                    progressColor: Color(0xff00BD40),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(1.h, 0.v, 0.h, 0.v),
                  width: 264.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(9.h, 0.v, 74.h, 1.v),
                        child: Text(
                          NumberFormat.decimalPatternDigits(
                                  locale: 'en_us', decimalDigits: 0)
                              .format(widget.goal.fundedAmount),
                          style: TextStyle(
                            fontSize: 16.fSize,
                            fontWeight: FontWeight.w600,
                            height: 1.2175.v,
                            color: Color(0xff00bd40),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0.h, 1.v, 0.h, 0.v),
                        child: Text(
                          NumberFormat.decimalPatternDigits(
                                  locale: 'en_us', decimalDigits: 0)
                              .format(widget.goal.price),
                          style: TextStyle(
                            fontSize: 16.fSize,
                            fontWeight: FontWeight.w600,
                            height: 1.2175.v,
                            color: Color(0xff00bd40),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
