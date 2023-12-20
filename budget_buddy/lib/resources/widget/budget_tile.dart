import 'package:budget_buddy/models/budget_model.dart';
import 'package:budget_buddy/resources/widget/category_icon.dart';
import 'package:budget_buddy/views/add_budget_view.dart';
import 'package:budget_buddy/views/budget_detail_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:budget_buddy/resources/app_export.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class BudgetTile extends StatefulWidget {
  Budget budget;
  BudgetTile({super.key, required this.budget});

  @override
  State<BudgetTile> createState() => _BudgetTileState();
}

class _BudgetTileState extends State<BudgetTile> {
  String categoryName = "";
  String imagePath = "";
  String timeLeft = "";
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCategoryData(widget.budget.userId, widget.budget.categoryId);
    timeLeft = calculateTimeDifference(widget.budget.dateEnd);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0.h, 0.v, 0.h, 15.v),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CategoryIcon(imagePath: imagePath),
        SizedBox(
          width: 7,
        ),
        widget.budget.expenseCap == 0
            ? Container(
                width: 186.h,
                margin: EdgeInsets.fromLTRB(5.h, 12.v, 0.h, 0.v),
                child: Text(
                  categoryName,
                  style: TextStyle(
                    fontSize: 20.fSize,
                    fontWeight: FontWeight.w400,
                    height: 1.2175.v,
                    color: Color(0xff000000),
                  ),
                ),
              )
            : GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BudgetDetailView(
                                budget: widget.budget,
                              )));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.only(left: 10.h, right: 10.h, bottom: 5.v),
                      width: 285.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            categoryName,
                            style: TextStyle(
                              fontSize: 18.fSize,
                              fontWeight: FontWeight.w500,
                              height: 1.2175.v,
                              color: Color(0xff000000),
                            ),
                          ),
                          Text(
                            timeLeft,
                            style: TextStyle(
                                fontSize: 16.fSize,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 285.h,
                      child: LinearPercentIndicator(
                        percent: widget.budget.spentAmount >=
                                widget.budget.expenseCap
                            ? widget.budget.expenseCap /
                                widget.budget.expenseCap
                            : widget.budget.spentAmount /
                                widget.budget.expenseCap,
                        backgroundColor: Color(0xffB7B7B7),
                        animation: true,
                        animationDuration: 1000,
                        progressColor: widget.budget.spentAmount >=
                                widget.budget.expenseCap
                            ? Color(0xffFF1D1D)
                            : Color(0xff00BD40),
                      ),
                    ),
                    Container(
                      width: 285.h,
                      padding:
                          EdgeInsets.only(left: 10.h, right: 10.h, top: 7.v),
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
        widget.budget.expenseCap == 0 ? Spacer() : SizedBox(),
        widget.budget.expenseCap == 0
            ? GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddBudgetView(
                                budget: widget.budget,
                              )));
                },
                child: Container(
                    margin: EdgeInsets.fromLTRB(0.h, 10.v, 0.h, 0.v),
                    child: SizedBox(
                        child: Image.asset(
                      "assets/images/plus.png",
                      fit: BoxFit.cover,
                      width: 26.adaptSize,
                      height: 26.adaptSize,
                    ))),
              )
            : SizedBox(),
      ]),
    );
  }
}
