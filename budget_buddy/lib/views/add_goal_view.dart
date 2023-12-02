// ignore_for_file: prefer_const_constructors

import 'package:budget_buddy/models/goal_model.dart';
import 'package:budget_buddy/resources/widget/category_icon.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:budget_buddy/resources/widget/custom_dropdown.dart';
import 'package:budget_buddy/resources/widget/custom_textfied.dart';
import 'package:budget_buddy/resources/widget/goal_icon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:budget_buddy/resources/app_export.dart';

class AddGoalView extends StatefulWidget {
  AddGoalView({super.key});

  @override
  State<AddGoalView> createState() => _AddGoalViewState();
}

class _AddGoalViewState extends State<AddGoalView> {
  @override
  void initState() {
    super.initState();
    loadImageFromFirebase();
  }

  final goalNameController = TextEditingController();

  final budgetController = TextEditingController();

  final timeController = TextEditingController();

  String imagePath =
      "https://firebasestorage.googleapis.com/v0/b/budget-buddy-se214.appspot.com/o/goal_icons%2Fsmartphone.png?alt=media&token=1951d101-b024-4b8c-864a-9f6da8158e9b";
  List<String> times = ['Day', 'Month', 'Year'];
  String? selectedTime = 'Day';

  List<String> imageUrls = [];

  //choose icon
  void updateSelectedIcon(String Path) {
    setState(() {
      imagePath = Path;
    });
  }

  //load icon images from Firebase Storage
  Future<void> loadImageFromFirebase() async {
    Reference folderRef = FirebaseStorage.instance.ref().child('goal_icons');

    try {
      final ListResult result = await folderRef.listAll();

      for (Reference ref in result.items) {
        String url = await ref.getDownloadURL();
        setState(() {
          imageUrls.add(url);
        });
      }
    } catch (e) {
      print('Error loading images: $e');
    }
  }

  //add new goal to firestore
  Future<void> addGoalToFirestore() async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;

      Goal newGoal = Goal(
        userId: userId,
        goalId: FirebaseFirestore.instance.collection('Goal').doc().id,
        name: goalNameController.text,
        imagePath: imagePath,
        goalAmount: double.parse(budgetController.text),
        fundAmount: 0,
        dateEnd: Timestamp.now(),
      );

      // await FirebaseFirestore.instance.collection('Goal');
    } catch (e) {}
  }

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
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close, size: 30)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
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
                      GoalIcon(imagePath: imagePath),
                      SizedBox(
                        width: 15,
                      ),
                      MyTextField(
                          width: 250.h,
                          hintText: AppLocalizations.of(context)!
                              .newgoal_goal_name_hint,
                          controller: goalNameController),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(57.h, 0.v, 0.h, 17.v),
                  child: MyTextField(
                      width: 250.h,
                      hintText: AppLocalizations.of(context)!
                          .newgoal_goal_budget_hint,
                      controller: budgetController),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(62.h, 0.v, 5.h, 0.v),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MyTextField(
                          width: 61, hintText: "", controller: timeController),
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
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 10),
            child: Text(
              AppLocalizations.of(context)!.goal_choose_icon,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 25,
                    mainAxisSpacing: 18),
                itemCount: imageUrls.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        updateSelectedIcon(imageUrls[index]);
                      },
                      child: GoalIcon(imagePath: imageUrls[index]));
                }),
          )
        ],
      ),
    ));
  }
}
