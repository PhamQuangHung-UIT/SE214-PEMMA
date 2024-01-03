import 'package:budget_buddy/models/transaction_model.dart' as model;
import 'package:budget_buddy/presenters/category_presenter.dart';
import 'package:budget_buddy/presenters/transaction_presenter.dart';
import 'package:budget_buddy/resources/widget/category_icon.dart';
import 'package:budget_buddy/resources/widget/small_category_icon.dart';
import 'package:budget_buddy/views/add_transaction_view.dart';
import 'package:budget_buddy/views/home_view.dart';
import 'package:budget_buddy/views/recent_transaction_view.dart';
import 'package:flutter/material.dart';
import 'package:budget_buddy/resources/app_export.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class TransactionInfo extends StatefulWidget {
  model.Transaction transaction;
  TransactionInfo({super.key, required this.transaction});

  @override
  State<TransactionInfo> createState() => _TransactionInfoState();
}

class _TransactionInfoState extends State<TransactionInfo> {
  final CategoryPresenter _categoryPresenter = CategoryPresenter();
  final TransactionPresenter _transactionPresenter = TransactionPresenter();
  String categoryName = "";
  String imagePath = "";
  bool isIncome = true;
  var formatter = NumberFormat('#,000');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchCategoryData(
        widget.transaction.userId, widget.transaction.categoryId);
    _fetchCategoryType(
        widget.transaction.userId, widget.transaction.categoryId);
  }

  void _fetchCategoryType(String userId, String? categoryId) {
    _categoryPresenter.fetchCategoryType(
      userId,
      categoryId,
      (isIncome) {
        setState(() {
          this.isIncome = isIncome;
        });
      },
      (error) {
        print("Error: $error");
      },
    );
  }

  void _fetchCategoryData(String userId, String? categoryId) {
    _categoryPresenter.fetchCategoryData(
      userId,
      categoryId,
      (categoryName, imagePath) {
        setState(() {
          this.categoryName = categoryName;
          this.imagePath = imagePath;
        });
      },
      (error) {
        print("Error: $error");
      },
    );
  }

  void _confirmDeleteTransaction(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            AppLocalizations.of(context)!.transaction_confirm_delete_title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content:
              Text(AppLocalizations.of(context)!.transaction_confirm_delete),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteTransactionOnFirestore(context);
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _deleteTransactionOnFirestore(BuildContext context) async {
    try {
      await _transactionPresenter.deleteTransaction(widget.transaction);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              AppLocalizations.of(context)!.transaction_delete_successfull),
        ),
      );
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => RecentTransaction()));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.transaction_delete_fail),
        ),
      );
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
          AppLocalizations.of(context)!.transaction_info_title,
          style: TextStyle(fontSize: 20.fSize, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xff03a700),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                //edit
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AddTransactionView.existingTransaction(
                                widget.transaction)));
              },
              icon: Icon(Icons.edit, size: 30.adaptSize)),
          IconButton(
              onPressed: () {
                //  Xóa
                _confirmDeleteTransaction(context);
              },
              icon: Icon(Icons.delete, size: 30.adaptSize)),
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close, size: 30.adaptSize)),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.h, vertical: 15.v),
        width: double.infinity,
        height: 255.v,
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
        child: Padding(
          padding: EdgeInsets.only(left: 12.h, top: 21.v),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                CategoryIcon(imagePath: imagePath),
                SizedBox(
                  width: 17.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      categoryName,
                      style: TextStyle(
                          fontSize: 20.fSize, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 5.v,
                    ),
                    Text(
                      formatter.format(widget.transaction.amount),
                      style: TextStyle(
                          fontSize: 20.fSize,
                          fontWeight: FontWeight.w600,
                          color: isIncome == true
                              ? Color(0xff00BD40)
                              : Color(0xffFF1D1D)),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 19.v,
            ),
            Padding(
              padding: EdgeInsets.only(left: 11.h),
              child: Row(
                children: [
                  SizedBox(
                    height: 30.v,
                    width: 30.h,
                    child: Image.asset("assets/images/calendar.png"),
                  ),
                  SizedBox(
                    width: 16.h,
                  ),
                  Text(
                    widget.transaction.date,
                    style: TextStyle(
                        fontSize: 16.fSize, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 19.v,
            ),
            Padding(
              padding: EdgeInsets.only(left: 11.h),
              child: Row(
                children: [
                  SizedBox(
                    height: 30.v,
                    width: 30.h,
                    child: Image.asset("assets/images/clock.png"),
                  ),
                  SizedBox(
                    width: 16.h,
                  ),
                  Text(
                    widget.transaction.time,
                    style: TextStyle(
                        fontSize: 16.fSize, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 19.v,
            ),
            Padding(
              padding: EdgeInsets.only(left: 11.h),
              child: Row(
                children: [
                  SizedBox(
                    height: 30.v,
                    width: 30.h,
                    child: Image.asset("assets/images/notes.png"),
                  ),
                  SizedBox(
                    width: 16.h,
                  ),
                  Text(
                    widget.transaction.note == ""
                        ? "___"
                        : widget.transaction.note,
                    style: TextStyle(
                        fontSize: 16.fSize,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff898989)),
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    ));
  }
}
