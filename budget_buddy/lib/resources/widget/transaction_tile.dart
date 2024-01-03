import 'package:budget_buddy/models/transaction_model.dart' as model;
import 'package:budget_buddy/presenters/category_presenter.dart';
import 'package:budget_buddy/resources/widget/category_icon.dart';
import 'package:budget_buddy/resources/widget/small_category_icon.dart';
import 'package:budget_buddy/views/transaction_info.dart';
import 'package:flutter/material.dart';
import 'package:budget_buddy/resources/app_export.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class TransactionTile extends StatefulWidget {
  model.Transaction transaction;
  TransactionTile({super.key, required this.transaction});

  @override
  State<TransactionTile> createState() => _TransactionTileState();
}

class _TransactionTileState extends State<TransactionTile> {
  final CategoryPresenter _categoryPresenter = CategoryPresenter();
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    TransactionInfo(transaction: widget.transaction)));
      },
      child: Container(
        width: double.infinity,
        height: 37.v,
        child: Row(children: [
          SmallCategoryIcon(imagePath: imagePath),
          SizedBox(
            width: 9.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                categoryName,
                style:
                    TextStyle(fontSize: 14.fSize, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 3.v,
              ),
              Text(
                widget.transaction.date,
                style: TextStyle(
                    color: Color(0xff004368),
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                widget.transaction.note,
                style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff5E5E5E),
                    fontWeight: FontWeight.w500),
              ),
              Text(
                isIncome == true
                    ? "+" + formatter.format(widget.transaction.amount)
                    : "-" + formatter.format(widget.transaction.amount),
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isIncome == true
                        ? Color(0xff00BD40)
                        : Color(0xffFF1D1D)),
              )
            ],
          )
        ]),
      ),
    );
  }
}
