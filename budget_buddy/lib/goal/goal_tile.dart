import 'package:budget_buddy/goal/goal_model.dart';
import 'package:flutter/material.dart';

class GoalTile extends StatefulWidget {
  Goal goal;
  GoalTile({super.key, required this.goal});
  @override
  State<GoalTile> createState() => _GoalTileState();
}

class _GoalTileState extends State<GoalTile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 13, 20),
          padding: EdgeInsets.fromLTRB(8, 7, 8, 7),
          height: 48,
          width: 48,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(360)),
          child: Center(
              child: SizedBox(
                  child: Image.asset(
            'assets/images/smartphone.png',
            fit: BoxFit.cover,
            width: 32,
            height: 32,
          ))),
        )
      ],
    );
  }
}
