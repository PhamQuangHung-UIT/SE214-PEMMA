import 'package:budget_buddy/models/goal_model.dart';
import 'package:budget_buddy/presenters/goal_presenter.dart';
import 'package:budget_buddy/presenters/user_presenter.dart';
import 'package:budget_buddy/resources/widget/custom_textfied.dart';
import 'package:budget_buddy/resources/widget/goal_icon.dart';
import 'package:budget_buddy/views/add_goal_view.dart';
import 'package:budget_buddy/views/goal_budget_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:budget_buddy/resources/app_export.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class FundGoalView extends StatefulWidget {
  Goal goal;
  FundGoalView({super.key, required this.goal});

  @override
  State<FundGoalView> createState() => _FundGoalViewState();
}

class _FundGoalViewState extends State<FundGoalView> {
  final UserPresenter _userPresenter = UserPresenter();
  final GoalPresenter _goalPresenter = GoalPresenter();

  late Future<DocumentSnapshot<Map<String, dynamic>>?> goalData;
  final fundController = TextEditingController();
  var formatter = NumberFormat('#,000');
  double balance = 0;

  Future<DocumentSnapshot<Map<String, dynamic>>?> fetchGoalData() async {
    try {
      return await _goalPresenter.fetchGoalData(widget.goal.goalId);
    } catch (e) {
      throw e;
    }
  }

  void updateGoal() async {
    if (fundController.text.isNotEmpty) {
      double fundAmount = double.parse(fundController.text);

      if (widget.goal.fundAmount == widget.goal.goalAmount) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Mục tiêu đã hoàn thành!',
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                fontSize: 16.fSize),
          ),
          duration: Duration(seconds: 2),
        ));
      } else {
        if (fundAmount < widget.goal.goalAmount) {
          try {
            await _goalPresenter.updateGoalFundAmount(
                widget.goal.goalId, fundAmount);
          } catch (e) {
            print("Error updating goal: $e");
          }

          // Cập nhật số dư trong collection "users"
          try {
            User? user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              String userId = user.uid;

              await _userPresenter.updateUserBalance(userId, fundAmount);
            }
          } catch (e) {
            print("Error updating user balance: $e");
            // Xử lý lỗi khi cập nhật balance người dùng
          }
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              'Số dư được nhập vượt quá số tiền mục tiêu!',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                  fontSize: 16.fSize),
            ),
            duration: Duration(seconds: 2),
          ));
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Vui lòng nhập số dư được thêm cho mục tiêu!',
          style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
              fontSize: 16.fSize),
        ),
        duration: Duration(seconds: 2),
      ));
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
  void initState() {
    // TODO: implement initState
    super.initState();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _loadUserBalance(user.uid);
      goalData = fetchGoalData();
    } else {
      print("User not signed in!");
    }
  }

  void _confirmDeleteGoal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            AppLocalizations.of(context)!.goal_confirm_delete_title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(AppLocalizations.of(context)!.goal_confirm_delete),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteGoalOnFirestore(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BudgetView()));
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _deleteGoalOnFirestore(BuildContext context) async {
    try {
      await _goalPresenter.deleteGoal(widget.goal.goalId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.goal_delete_successfull),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.goal_delete_fail),
        ),
      );
    }
  }

  String calculateTimeDifference(Timestamp timeStamp) {
    DateTime now = DateTime.now();
    DateTime dateTime = timeStamp.toDate();

    Duration difference = now.difference(dateTime);

    int daysDifference = difference.inDays;

    if (daysDifference == 0) {
      return "Ended today";
    } else if (daysDifference < 0) {
      Duration absDifference = now.difference(dateTime).abs();
      daysDifference = absDifference.inDays;
      int monthsDifference = (daysDifference / 30).floor();
      int yearsDifference = (daysDifference / 365).floor();
      if (daysDifference < 30) {
        return daysDifference == 1
            ? '$daysDifference day left'
            : '$daysDifference days left';
      } else if (daysDifference < 365) {
        return monthsDifference == 1
            ? '$monthsDifference month left'
            : '$monthsDifference months left';
      } else {
        return yearsDifference == 1
            ? '$yearsDifference year left'
            : '$yearsDifference years left';
      }
    } else {
      Duration absDifference = now.difference(dateTime).abs();
      daysDifference = absDifference.inDays;
      return "Ended " + daysDifference.toString() + " days ago";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Color(0xffDEDEDE),
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                AppLocalizations.of(context)!.fund_goal_title,
                style:
                    TextStyle(fontSize: 20.fSize, fontWeight: FontWeight.bold),
              ),
              backgroundColor: Color(0xff03a700),
              actions: <Widget>[
                IconButton(
                    onPressed: () {
                      updateGoal();
                    },
                    icon: Icon(Icons.check, size: 30.adaptSize)),
              ],
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close, size: 30.adaptSize)),
            ),
            body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>?>(
                future: goalData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return Center(child: Text('No data available'));
                  } else {
                    // Lấy thông tin từ snapshot và hiển thị lên các Text
                    var userData =
                        snapshot.data!.data() as Map<String, dynamic>?;
                    if (userData != null) {
                      String goalName = userData['name'];
                      double goalAmount =
                          (userData['goalAmount'] as num).toDouble();
                      String imagePath = userData['imagePath'];
                      double fundAmount =
                          (userData['fundAmount'] as num).toDouble();
                      Timestamp dateEnd = userData['dateEnd'];
                      String timeDifference = calculateTimeDifference(dateEnd);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: 15.h, right: 15.h, top: 20.v),
                            width: double.infinity,
                            height: 324.v,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(7),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x3f000000),
                                    offset: Offset(0, 4),
                                    blurRadius: 2,
                                  )
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.h, right: 24.h, top: 17.v),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GoalIcon(imagePath: imagePath),
                                      Container(
                                        padding: EdgeInsets.only(
                                            top: 13.v,
                                            bottom: 14.v,
                                            left: 15.h),
                                        width: 248.h,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Color(0xff000000)),
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Text(
                                          goalName,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 11.v,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 87.h,
                                    ),
                                    MyTextField(
                                        width: 248.h,
                                        hintText: "Fund your goal",
                                        controller: fundController),
                                  ],
                                ),
                                SizedBox(
                                  height: 28.v,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 87.h, right: 28.h),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.balance,
                                        style: TextStyle(
                                            fontSize: 15.fSize,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        formatter.format(balance) +
                                            " " +
                                            AppLocalizations.of(context)!
                                                .currency_icon,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 32.v,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 87.h),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                          height: 26.v,
                                          width: 26.h,
                                          child: Image.asset(
                                              "assets/images/calendar-1.png")),
                                      SizedBox(
                                        width: 13.h,
                                      ),
                                      Text(
                                        timeDifference,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 34.v),
                                  child: Container(
                                    width: 320.h,
                                    child: LinearPercentIndicator(
                                      percent: fundAmount / goalAmount,
                                      backgroundColor: Color(0xffB7B7B7),
                                      animation: true,
                                      animationDuration: 1000,
                                      progressColor: Color(0xff00BD40),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.v,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 28.h),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        NumberFormat.decimalPatternDigits(
                                          locale: 'en_us',
                                          decimalDigits: 0,
                                        ).format(fundAmount),
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
                                        ).format(goalAmount),
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
                          Padding(
                            padding: EdgeInsets.only(
                                top: 33.v, left: 44.h, right: 44.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddGoalView.existingGoal(
                                                    widget.goal)));
                                  },
                                  child: Container(
                                    width: 132.h,
                                    height: 56.v,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white),
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Center(
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .edit_goal_button,
                                        style: TextStyle(
                                            fontSize: 14.fSize,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _confirmDeleteGoal(context);
                                  },
                                  child: Container(
                                    width: 132.h,
                                    height: 56.v,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xffff0000)),
                                        color: Color(0xffff0000),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Center(
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .delete_goal_button,
                                        style: TextStyle(
                                            fontSize: 14.fSize,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    }
                    return Container();
                  }
                })));
  }
}
