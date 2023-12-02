import 'package:budget_buddy/resources/widget/category_icon.dart';
import 'package:budget_buddy/resources/widget/custom_dropdown.dart';
import 'package:budget_buddy/resources/widget/custom_textfied.dart';
import 'package:flutter/material.dart';
import 'package:budget_buddy/resources/app_export.dart';
import 'package:intl/intl.dart';

class AddBudgetView extends StatefulWidget {
  const AddBudgetView({super.key});

  @override
  State<AddBudgetView> createState() => _AddBudgetViewState();
}

class _AddBudgetViewState extends State<AddBudgetView> {
  final budgetController = TextEditingController();
  List<String> options = ['This month only', 'Every month'];
  String? selectedOption = 'This month only';
  double balance = 9999999;
  var formatter = NumberFormat('#,000');
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xffdedede),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.add_budget_title,
          style: TextStyle(fontSize: 20.fSize, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xff03a700),
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: Icon(Icons.check, size: 30)),
        ],
        leading:
            IconButton(onPressed: () {}, icon: Icon(Icons.close, size: 30)),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(16.h, 19.v, 15.h, 0.v),
        padding: EdgeInsets.fromLTRB(20.h, 17.v, 24.h, 26.v),
        width: 359.h,
        height: 274.v,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0.h, 0.v, 0.h, 5.v),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CategoryIcon(imagePath: "assets/images/restaurant.png"),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0.h, 0.v, 0.h, 2.v),
                            child: Text(
                              "Food",
                              style: TextStyle(
                                  fontSize: 20.fSize,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            child: Text(
                              AppLocalizations.of(context)!
                                  .set_budget_description,
                              style: TextStyle(
                                  fontSize: 14.fSize,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 55),
              child: MyTextField(
                  width: 248,
                  hintText: AppLocalizations.of(context)!.budget,
                  controller: budgetController),
            ),
            Container(
              margin: EdgeInsets.only(top: 15, right: 23),
              child:
                  CustomDropdown(items: options, selectedItem: selectedOption),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0.h, 20.v, 2.5.h, 0.v),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                      child: Text(
                    AppLocalizations.of(context)!.balance,
                    style: TextStyle(
                        fontSize: 15.fSize, fontWeight: FontWeight.w500),
                  )),
                  Spacer(),
                  Center(
                      child: Text(
                    formatter.format(balance) +
                        " " +
                        AppLocalizations.of(context)!.currency_icon,
                    style: TextStyle(
                        fontSize: 20.fSize, fontWeight: FontWeight.w600),
                  )),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
