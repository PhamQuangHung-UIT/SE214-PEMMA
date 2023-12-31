// ignore_for_file: prefer_const_constructors
import 'package:budget_buddy/models/budget_model.dart';
import 'package:budget_buddy/models/goal_model.dart';
import 'package:budget_buddy/presenters/goal_presenter.dart';
import 'package:budget_buddy/resources/widget/category_icon.dart';
import 'package:budget_buddy/views/goal_budget_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:budget_buddy/resources/widget/custom_dropdown.dart';
import 'package:budget_buddy/resources/widget/custom_textfied.dart';
import 'package:budget_buddy/resources/widget/goal_icon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:budget_buddy/resources/app_export.dart';
import 'package:intl/intl.dart';

class AddGoalView extends StatefulWidget {
  Goal? existingGoal;
  AddGoalView({super.key});
  AddGoalView.existingGoal(Goal goal, {super.key}) {
    existingGoal = goal;
  }

  @override
  State<AddGoalView> createState() => _AddGoalViewState();
}

class _AddGoalViewState extends State<AddGoalView> {
  @override
  void initState() {
    if (widget.existingGoal != null) {
      NumberFormat formatter = NumberFormat('000');
      imagePath = widget.existingGoal!.imagePath;
      goalNameController.text = widget.existingGoal!.name;
      budgetController.text = formatter.format(widget.existingGoal!.goalAmount);
    }
    super.initState();
  }

  final GoalPresenter _goalPresenter = GoalPresenter();
  final goalNameController = TextEditingController();

  final budgetController = TextEditingController();

  final timeController = TextEditingController();

  String imagePath = "assets/images/smartphone.png";
  List<String> times = ['Day', 'Month', 'Year'];
  String? selectedTime = 'Day';
  var formatter = NumberFormat('#,000');
  List<String> imageUrls = [
    "assets/images/building.png",
    "assets/images/cosmetics.png",
    "assets/images/giftbox.png",
    "assets/images/key.png",
    "assets/images/car.png",
    "assets/images/laptop.png",
    "assets/images/plane.png",
    "assets/images/real_estate.png",
    "assets/images/smartphone.png",
    "assets/images/tablet.png",
  ];

  //choose icon
  void updateSelectedIcon(String Path) {
    setState(() {
      imagePath = Path;
    });
  }

  Timestamp addDaysToTimestamp(int number, String? period) {
    int daysToAdd = 0;
    if (period == "Day") {
      daysToAdd = number * 1;
    }
    if (period == "Month") {
      daysToAdd = number * 30;
    }
    if (period == "Year") {
      daysToAdd = number * 365;
    }

    DateTime now = DateTime.now();
    DateTime futureDate = now.add(Duration(days: daysToAdd));
    Timestamp futureTimestamp = Timestamp.fromDate(futureDate);
    return futureTimestamp;
  }

  void addNewGoal(Goal newGoal) {
    _goalPresenter.addGoal(
      newGoal,
      () {},
      (error) {
        // Xử lý lỗi khi thêm mới Goal
      },
    );
  }

  //add new goal to firestore
  Future<void> addGoalToFirestore() async {
    if (goalNameController.text.isEmpty ||
        budgetController.text.isEmpty ||
        timeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Vui lòng nhập đầy đủ thông tin mục tiêu!',
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                fontSize: 16.fSize),
          ),
          duration: Duration(seconds: 2), // Thời gian hiển thị SnackBar
        ),
      );
    } else {
      try {
        String userId = FirebaseAuth.instance.currentUser!.uid;
        String? gID;
        double fundAmount;
        if (widget.existingGoal == null) {
          gID = FirebaseFirestore.instance.collection('goals').doc().id;
          fundAmount = 0;
        } else {
          gID = widget.existingGoal!.goalId;
          fundAmount = widget.existingGoal!.fundAmount;
        }

        Goal newGoal = Goal(
          userId: userId,
          goalId: gID,
          name: goalNameController.text,
          imagePath: imagePath,
          goalAmount: double.parse(budgetController.text),
          fundAmount: fundAmount,
          dateEnd:
              addDaysToTimestamp(int.parse(timeController.text), selectedTime),
        );

        if (double.parse(budgetController.text) < fundAmount) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Số tiền của mục tiêu không thể nhỏ hơn số dư đã đưa vào mục tiêu: ' +
                    formatter.format(fundAmount),
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    fontSize: 16.fSize),
              ),
              duration: Duration(seconds: 2), // Thời gian hiển thị SnackBar
            ),
          );
        } else {
          addNewGoal(newGoal);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const BudgetView()));
        }
      } catch (e) {
        print("Error adding goal to Firestore: $e");
      }
    }
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
          AppLocalizations.of(context)!.add_goal_title,
          style: TextStyle(fontSize: 20.fSize, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xff03a700),
        actions: <Widget>[
          IconButton(
              onPressed: addGoalToFirestore, icon: Icon(Icons.check, size: 30)),
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
                      CustomDropdown(
                        items: times,
                        selectedItem: selectedTime,
                        onChanged: (newValue) {
                          setState(() {
                            selectedTime =
                                newValue; // Cập nhật giá trị selectedTime
                          });
                        },
                      )
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
