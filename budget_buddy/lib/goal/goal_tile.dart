import 'package:budget_buddy/goal/goal_model.dart';
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
      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 13, 10),
            padding: EdgeInsets.fromLTRB(8, 7, 8, 7),
            height: 48,
            width: 48,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(360)),
            child: Center(
                child: SizedBox(
                    child: Image.asset(
              widget.goal.imagePath,
              fit: BoxFit.cover,
              width: 32,
              height: 32,
            ))),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 3, 0, 0),
            width: 272,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 12),
                  child: Text(
                    widget.goal.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      height: 1.2175,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 1, 5),
                  width: 270,
                  height: 4,
                  child: LinearPercentIndicator(
                    width: 270,
                    percent: widget.goal.fundedAmount / widget.goal.price,
                    backgroundColor: Color(0xffB7B7B7),
                    animation: true,
                    animationDuration: 1000,
                    progressColor: Color(0xff00BD40),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(1, 0, 0, 0),
                  width: 264,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(9, 0, 74, 1),
                        child: Text(
                          NumberFormat.decimalPatternDigits(
                                  locale: 'en_us', decimalDigits: 0)
                              .format(widget.goal.fundedAmount),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            height: 1.2175,
                            color: Color(0xff00bd40),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 1, 0, 0),
                        child: Text(
                          NumberFormat.decimalPatternDigits(
                                  locale: 'en_us', decimalDigits: 0)
                              .format(widget.goal.price),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            height: 1.2175,
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
