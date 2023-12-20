import 'package:budget_buddy/models/budget_model.dart';
import 'package:budget_buddy/presenters/budget_presenter.dart';
import 'package:budget_buddy/resources/app_export.dart';
import 'package:budget_buddy/resources/widget/category_icon.dart';
import 'package:budget_buddy/views/add_budget_view.dart';
import 'package:budget_buddy/views/goal_budget_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';

class BudgetDetailView extends StatefulWidget {
  Budget budget;
  BudgetDetailView({super.key, required this.budget});

  @override
  State<BudgetDetailView> createState() => _BudgetDetailViewState();
}

class _BudgetDetailViewState extends State<BudgetDetailView> {
  final BudgetPresenter _budgetPresenter = BudgetPresenter();
  String categoryName = "";
  var formatter = NumberFormat('#,000');
  String imagePath = "";
  void fetchCategoryData(String userId, String categoryId) {
    FirebaseFirestore.instance
        .collection("categories")
        .where("userID", isEqualTo: userId)
        .where("categoryID", isEqualTo: categoryId)
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        String cName = querySnapshot.docs[0]['cName'];
        String cImagePath = querySnapshot.docs[0]['cImagePath'];

        setState(() {
          categoryName = cName;
          imagePath = cImagePath;
        });
      } else {
        print("Document not found!");
      }
    }, onError: (error) {
      print("Error: $error");
    });
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

  void _confirmDeleteBudget(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            AppLocalizations.of(context)!.budget_confirm_delete_title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(AppLocalizations.of(context)!.budget_confirm_delete),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                resetBudgetOnFirebase();
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

  Future<void> resetBudgetOnFirebase() async {
    DateTime now = DateTime.now();
    Timestamp nowTimestamp = Timestamp.fromDate(now);
    Budget newBudget = Budget(
      userId: widget.budget.userId,
      budgetId: widget.budget.budgetId,
      categoryId: widget.budget.categoryId,
      spentAmount: 0,
      expenseCap: 0,
      dateStart: nowTimestamp,
      dateEnd: nowTimestamp,
    );

    addNewBudget(newBudget);
  }

  void addNewBudget(Budget newBudget) {
    _budgetPresenter.addBudget(
      newBudget,
      () {},
      (error) {
        // Xử lý lỗi khi thêm mới Goal
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCategoryData(widget.budget.userId, widget.budget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xffDEDEDE),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.add_budget_title,
          style: TextStyle(fontSize: 20.fSize, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xff03a700),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddBudgetView(
                              budget: widget.budget,
                            )));
              },
              icon: Icon(Icons.edit, size: 30.adaptSize)),
          IconButton(
              onPressed: () {
                _confirmDeleteBudget(context);
              },
              icon: Icon(Icons.delete, size: 30.adaptSize)),
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close, size: 30.adaptSize)),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              margin: EdgeInsets.only(top: 14.v),
              width: 359.h,
              height: 218.v,
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                borderRadius: BorderRadius.circular(7),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x3f000000),
                    offset: Offset(0.h, 4.v),
                    blurRadius: 2,
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20.v, left: 20.h),
                    child: CategoryIcon(imagePath: imagePath),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.v, left: 5.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.h),
                          child: Text(
                            categoryName,
                            style: TextStyle(
                                fontSize: 20.fSize,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        SizedBox(
                          height: 9.v,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8.h),
                          child: Text(
                            formatter.format(widget.budget.expenseCap) +
                                " " +
                                AppLocalizations.of(context)!.currency_icon,
                            style: TextStyle(
                                fontSize: 20.fSize,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10.v, left: 8.h),
                          width: 260.h,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Spent",
                                  style: TextStyle(
                                    fontSize: 14.fSize,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  "Expense left",
                                  style: TextStyle(
                                      fontSize: 14.fSize,
                                      fontWeight: FontWeight.w400),
                                )
                              ]),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 6.v, bottom: 6.v),
                          width: 270.h,
                          child: LinearPercentIndicator(
                            percent: widget.budget.spentAmount /
                                widget.budget.expenseCap,
                            backgroundColor: Color(0xffB7B7B7),
                            animation: true,
                            animationDuration: 1000,
                            progressColor: Color(0xff00BD40),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 8.h),
                          width: 260.h,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  NumberFormat.decimalPatternDigits(
                                    locale: 'en_us',
                                    decimalDigits: 0,
                                  ).format(widget.budget.spentAmount),
                                  style: TextStyle(
                                    fontSize: 16.fSize,
                                    fontWeight: FontWeight.w600,
                                    height: 1.2175.v,
                                    color: widget.budget.spentAmount >=
                                            widget.budget.expenseCap
                                        ? Color(0xffFF1D1D)
                                        : Color(0xff00bd40),
                                  ),
                                ),
                                Text(
                                  NumberFormat.decimalPatternDigits(
                                    locale: 'en_us',
                                    decimalDigits: 0,
                                  ).format(widget.budget.expenseCap),
                                  style: TextStyle(
                                    fontSize: 16.fSize,
                                    fontWeight: FontWeight.w600,
                                    height: 1.2175.v,
                                    color: Color(0xff00bd40),
                                  ),
                                ),
                              ]),
                        ),
                        SizedBox(
                          height: 26.v,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 7.h),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 26.v,
                                width: 26.h,
                                child:
                                    Image.asset("assets/images/calendar-1.png"),
                              ),
                              SizedBox(
                                width: 12.h,
                              ),
                              Text(
                                calculateTimeDifference(widget.budget.dateEnd),
                                style: TextStyle(
                                    fontSize: 16.fSize,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )),
        ],
      ),
    ));
  }
}
