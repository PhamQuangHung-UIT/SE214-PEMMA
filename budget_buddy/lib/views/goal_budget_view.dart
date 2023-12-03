// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:budget_buddy/models/budget_model.dart';
import 'package:budget_buddy/resources/app_export.dart';
import 'package:budget_buddy/models/goal_model.dart';
import 'package:budget_buddy/resources/widget/budget_tile.dart';
import 'package:budget_buddy/resources/widget/goal_tile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BudgetView extends StatefulWidget {
  const BudgetView({super.key});

  @override
  State<BudgetView> createState() => _BudgetViewState();
}

class _BudgetViewState extends State<BudgetView> {
  double balance = 9999999;
  var formatter = NumberFormat('#,000');
  List<Budget> budgetList = [
    Budget(
        userid: "",
        categoryName: "Food",
        imagePath: "assets/images/restaurant.png",
        budget: 0,
        spentAmount: 0,
        isEveryMonth: false),
    Budget(
        userid: "",
        categoryName: "Fuel",
        imagePath: "assets/images/fuel.png",
        budget: 0,
        spentAmount: 0,
        isEveryMonth: false),
    Budget(
        userid: "",
        categoryName: "Clothes",
        imagePath: "assets/images/casual-t-shirt-.png",
        budget: 0,
        spentAmount: 0,
        isEveryMonth: false),
    Budget(
        userid: "",
        categoryName: "Shopping",
        imagePath: "assets/images/shopping-bag.png",
        budget: 0,
        spentAmount: 0,
        isEveryMonth: false),
    Budget(
        userid: "",
        categoryName: "Electricity bill",
        imagePath: "assets/images/electricity-bill.png",
        budget: 0,
        spentAmount: 0,
        isEveryMonth: false),
  ];
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
                padding: EdgeInsets.fromLTRB(28.h, 49.5.v, 24.h, 27.v),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0.h, 0.v, 4.h, 12.v),
                        child: Text(AppLocalizations.of(context)!.budget,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24.fSize,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0.h, 0.v, 8.h, 1.v),
                        child: Text(
                          AppLocalizations.of(context)!.balance,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15.fSize, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0.h, 0.v, 0.h, 10.v),
                        child: Text(
                          formatter.format(balance) +
                              " " +
                              AppLocalizations.of(context)!.currency_icon,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20.fSize, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.fromLTRB(3.h, 0.v, 0.h, 0.v),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Container(
                                margin:
                                    EdgeInsets.fromLTRB(0.h, 0.v, 203.h, 0.v),
                                child: Text(
                                  AppLocalizations.of(context)!.goal,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 24.fSize,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Container(
                                margin:
                                    EdgeInsets.fromLTRB(0.h, 0.5.v, 0.h, 0.v),
                                width: 63.h,
                                height: 34.v,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Color(0xff03a700)),
                                    color: Color(0xff03a700),
                                    borderRadius: BorderRadius.circular(7)),
                                child: Center(
                                  child: Text(
                                    "ADD",
                                    style: TextStyle(
                                        fontSize: 16.fSize,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ))
                          ],
                        )),
                    Container(
                        margin: EdgeInsets.fromLTRB(2.h, 0.v, 0.h, 0.v),
                        height: 230.v,
                        child: ListView.builder(
                          padding: EdgeInsets.only(top: 10.v),
                          itemCount: goalList.length,
                          itemBuilder: (context, index) {
                            return GoalTile(goal: goalList[index]);
                          },
                        )),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0.h, 10.v, 0.h, 5.v),
                          child: Text(
                            AppLocalizations.of(context)!.budget,
                            style: TextStyle(
                                fontSize: 24.fSize,
                                fontWeight: FontWeight.w700,
                                height: 1.2175.v,
                                color: Color(0xff000000)),
                          ),
                        ),
                      ],
                    ),
                    Container(
                        margin: EdgeInsets.fromLTRB(2.h, 0.v, 0.h, 0.v),
                        height: 350.v,
                        child: ListView.builder(
                          padding: EdgeInsets.only(top: 10.v),
                          itemCount: budgetList.length,
                          itemBuilder: (context, index) {
                            return BudgetTile(budget: budgetList[index]);
                          },
                        )),
                  ],
                ),
              )
            ],
          ))),
    );
  }
}
