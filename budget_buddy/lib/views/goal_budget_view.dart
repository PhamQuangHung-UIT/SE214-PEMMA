// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'dart:ffi';
import 'package:budget_buddy/resources/app_export.dart';
import 'package:budget_buddy/models/goal_model.dart';
import 'package:budget_buddy/resources/widget/goal_tile.dart';
import 'package:flutter/material.dart';

class BudgetView extends StatefulWidget {
  const BudgetView({super.key});

  @override
  State<BudgetView> createState() => _BudgetViewState();
}

class _BudgetViewState extends State<BudgetView> {
  String balance = "9,999,999 đ";
  List<Goal> goalList = [
    Goal(
        userid: "",
        name: "Iphone 15 Pro Max",
        imagePath: "assets/images/smartphone.png",
        price: 35000000,
        fundedAmount: 17000000),
    Goal(
        userid: "",
        name: "Ipad Pro",
        imagePath: "assets/images/smartphone.png",
        price: 45000000,
        fundedAmount: 15000000),
    Goal(
        userid: "",
        name: "Macbook Pro",
        imagePath: "assets/images/smartphone.png",
        price: 45000000,
        fundedAmount: 15000000),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(28, 49.5, 24, 27),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 4, 12),
                        child: Text(AppLocalizations.of(context)!.budget,
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
                        margin: EdgeInsets.fromLTRB(3, 0, 0, 0),
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
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.fromLTRB(0, 0.5, 0, 0),
                                width: 63,
                                height: 34,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Color(0xff03a700)),
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
                        margin: EdgeInsets.fromLTRB(2, 0, 0, 0),
                        height: 235,
                        child: ListView.builder(
                          padding: EdgeInsets.only(top: 10),
                          itemCount: goalList.length,
                          itemBuilder: (context, index) {
                            return GoalTile(goal: goalList[index]);
                          },
                        )),
                    Center(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 162, 18),
                        child: Text(
                          'Expense caps',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              height: 1.2175,
                              color: Color(0xff000000)),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ))),
    );
  }
}
