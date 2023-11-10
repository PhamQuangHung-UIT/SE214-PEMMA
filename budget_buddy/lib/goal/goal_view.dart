// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'dart:ffi';

import 'package:budget_buddy/goal/goal_model.dart';
import 'package:budget_buddy/goal/goal_tile.dart';
import 'package:flutter/material.dart';

class Budget extends StatefulWidget {
  const Budget({super.key});

  @override
  State<Budget> createState() => _BudgetState();
}

class _BudgetState extends State<Budget> {
  String balance = "9,999,999 đ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(28, 49.5, 24, 27),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 4, 12),
                      child: Text("Budget",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 8, 1),
                      child: Text(
                        "BALANCE",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 9, 10),
                      child: Text(
                        balance,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(3, 0, 0, 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 203, 0),
                              child: Text(
                                "Goals",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.fromLTRB(0, 0.5, 0, 0),
                              width: 63,
                              height: 34,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xff03a700)),
                                  color: Color(0xff03a700),
                                  borderRadius: BorderRadius.circular(7)),
                              child: Center(
                                child: Text(
                                  "ADD",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ))
                        ],
                      )),
                  Container(
                      margin: EdgeInsets.fromLTRB(2, 0, 3, 20),
                      child: GoalTile(
                          goal: Goal(
                              fundedAmount: 17500000,
                              name: "Iphone 15 Pro Max",
                              imagePath: "lib/images/smartphone.png",
                              price: 35000000)))
                ],
              ),
            )
          ],
        )));
  }
}
