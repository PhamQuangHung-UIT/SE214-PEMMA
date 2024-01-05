// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:budget_buddy/models/budget_model.dart';
import 'package:budget_buddy/presenters/budget_presenter.dart';
import 'package:budget_buddy/presenters/goal_presenter.dart';
import 'package:budget_buddy/presenters/user_presenter.dart';
import 'package:budget_buddy/resources/app_export.dart';
import 'package:budget_buddy/models/goal_model.dart';
import 'package:budget_buddy/resources/widget/budget_tile.dart';
import 'package:budget_buddy/resources/widget/custom_elevated_button.dart';
import 'package:budget_buddy/resources/widget/goal_tile.dart';
import 'package:budget_buddy/views/add_goal_view.dart';
import 'package:budget_buddy/views/category_view.dart';
import 'package:budget_buddy/views/fund_goal_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BudgetView extends StatefulWidget {
  const BudgetView({super.key});

  @override
  State<BudgetView> createState() => _BudgetViewState();
}

class _BudgetViewState extends State<BudgetView> {
  final GoalPresenter _goalPresenter = GoalPresenter();
  final BudgetPresenter _budgetPresenter = BudgetPresenter();
  final UserPresenter _userPresenter = UserPresenter();
  double balance = 0;
  var formatter = NumberFormat.decimalPattern();
  List<Budget> budgetList = [];
  List<Goal> goalList = [];

  @override
  void initState() {
    super.initState();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      _goalPresenter.fetchGoals(
        userId,
        (goals) {
          setState(() {
            goalList.clear();
            goalList.addAll(goals);
          });
        },
        (error) {
          // Handle error when fetching goals
        },
      );
      _budgetPresenter.fetchBudgets(userId, (budgets) {
        setState(() {
          budgetList.clear();
          budgetList.addAll(budgets);
        });
      }, (error) {
        // Handle error when fetching budgets
      });
      _loadUserBalance(userId);
    } else {
      // Handle user not logged in
    }
  }

  Future<void> _loadUserBalance(String userId) async {
    try {
      _userPresenter.listenUserBalance(
        userId,
        (double storedBalance) {
          setState(() {
            balance = storedBalance;
          });
        },
        (String error) {
          // Xử lý lỗi
        },
      );
      ;
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
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
                                fontSize: 15.fSize,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0.h, 0.v, 0.h, 10.v),
                          child: Text(
                            "${formatter.format(balance)} ${AppLocalizations.of(context)!.currency_icon}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20.fSize,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.fromLTRB(0.h, 0.v, 8.h, 0.v),
                          child: Row(
                            children: [
                              Center(
                                child: Container(

                                  child: Text(
                                    AppLocalizations.of(context)!.goal,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 24.fSize,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Spacer(),
                              CustomElevatedButton(
                                width: 80.h,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddGoalView()),
                                  );
                                },
                                text: AppLocalizations.of(context)!
                                            .add_button_title,
                              )
                            ],
                          )),
                      goalList.isEmpty
                          ? SizedBox(
                              height: 250.v,
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context)!.empty_goal_msg,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            )
                          : SizedBox(
                              height: 250.v,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: goalList.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  FundGoalView(
                                                    goal: goalList[index],
                                                  )),
                                        );
                                      },
                                      child: GoalTile(goal: goalList[index]));
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
                      budgetList.isEmpty
                          ? Container(
                              height: 300.v,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.empty_budget_msg,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16.fSize,
                                          height: 1.5,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 10.v,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CategoryView()));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 26.v,
                                            width: 26.h,
                                            child: Image.asset(
                                                "assets/images/plus.png"),
                                          ),
                                          SizedBox(
                                            width: 8.h,
                                          ),
                                          Text(
                                            "Thêm ngay",
                                            style: TextStyle(
                                                color: Color(0xff03A700),
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Container(
                              height: 300.v,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: budgetList.length,
                                itemBuilder: (context, index) {
                                  return BudgetTile(budget: budgetList[index]);
                                },
                              )),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
