// ignore_for_file: prefer_const_constructors

import 'package:budget_buddy/resources/widget/category_icon.dart';
import 'package:budget_buddy/resources/widget/custom_dropdown.dart';
import 'package:budget_buddy/resources/widget/custom_textfied.dart';
import 'package:flutter/material.dart';
import 'package:budget_buddy/resources/app_export.dart';

class AddGoalView extends StatefulWidget {
  AddGoalView({super.key});

  @override
  State<AddGoalView> createState() => _AddGoalViewState();
}

class _AddGoalViewState extends State<AddGoalView> {
  final goalNameController = TextEditingController();

  final budgetController = TextEditingController();

  final timeController = TextEditingController();
  List<String> times = ['Day', 'Month', 'Year'];
  String? selectedTime = 'Day';

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
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
        height: 240.v,
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
              margin: EdgeInsets.fromLTRB(0.h, 0.v, 0.h, 12.v),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CategoryIcon(imagePath: "assets/images/restaurant.png"),
                  MyTextField(
                      width: 250.h,
                      hintText:
                          AppLocalizations.of(context)!.newgoal_goal_name_hint,
                      controller: goalNameController),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(57.h, 0.v, 0.h, 17.v),
              child: MyTextField(
                  width: 250,
                  hintText:
                      AppLocalizations.of(context)!.newgoal_goal_budget_hint,
                  controller: budgetController),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(64.h, 0.v, 5.h, 0.v),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyTextField(
                      width: 61, hintText: "1", controller: timeController),
                  SizedBox(
                    width: 20,
                  ),
                  CustomDropdown(items: times, selectedItem: selectedTime)
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
