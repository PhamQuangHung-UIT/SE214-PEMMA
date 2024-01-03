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
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CategoryIcon(imagePath: widget.goal.imagePath),
          Container(
            width: 285.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 9),
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
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: 285.h,
                  child: LinearPercentIndicator(
                    percent: widget.goal.fundAmount / widget.goal.goalAmount,
                    backgroundColor: Color(0xffB7B7B7),
                    animation: true,
                    animationDuration: 1000,
                    progressColor: Color(0xff00BD40),
                  ),
                ),
                SizedBox(
                  height: 5,
                ), // Added SizedBox for spacing
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 9),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        NumberFormat.decimalPatternDigits(
                          locale: 'en_us',
                          decimalDigits: 0,
                        ).format(widget.goal.fundAmount),
                        style: TextStyle(
                          fontSize: 16.fSize,
                          fontWeight: FontWeight.w600,
                          height: 1.2175.v,
                          color: Color(0xff00bd40),
                        ),
                      ),
                      Text(
                        NumberFormat.decimalPatternDigits(
                          locale: 'en_us',
                          decimalDigits: 0,
                        ).format(widget.goal.goalAmount),
                        style: TextStyle(
                          fontSize: 16.fSize,
                          fontWeight: FontWeight.w600,
                          height: 1.2175.v,
                          color: Color(0xff00bd40),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
