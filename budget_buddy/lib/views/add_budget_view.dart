import 'package:budget_buddy/models/budget_model.dart';
import 'package:budget_buddy/presenters/budget_presenter.dart';
import 'package:budget_buddy/resources/widget/category_icon.dart';
import 'package:budget_buddy/resources/widget/custom_dropdown.dart';
import 'package:budget_buddy/resources/widget/custom_textfied.dart';
import 'package:budget_buddy/views/goal_budget_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:budget_buddy/resources/app_export.dart';
import 'package:intl/intl.dart';

class AddBudgetView extends StatefulWidget {
  Budget budget;
  AddBudgetView({super.key, required this.budget});

  @override
  State<AddBudgetView> createState() => _AddBudgetViewState();
}

class _AddBudgetViewState extends State<AddBudgetView> {
  final BudgetPresenter _budgetPresenter = BudgetPresenter();
  final budgetController = TextEditingController();
  List<String> times = ['Day', 'Month', 'Year'];
  String? selectedTime = 'Day';
  double balance = 9999999;
  final timeController = TextEditingController();
  var formatter = NumberFormat('#,000');

  String categoryName = "";
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

  void addNewBudget(Budget newBudget) {
    _budgetPresenter.addBudget(
      newBudget,
      () {},
      (error) {
        // Xử lý lỗi khi thêm mới Goal
      },
    );
  }

  //add new goal to firestore
  Future<void> addBudgetToFirestore() async {
    if (budgetController.text.isEmpty || timeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Vui lòng nhập đầy đủ thông tin ngân sách!',
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
        double spentAmount;
        if (widget.budget.spentAmount == 0) {
          spentAmount = 0;
        } else {
          spentAmount = widget.budget.spentAmount;
        }

        DateTime now = DateTime.now();
        Timestamp nowTimestamp = Timestamp.fromDate(now);
        Budget newBudget = Budget(
            userId: userId,
            budgetId: widget.budget.budgetId,
            categoryId: widget.budget.categoryId,
            spentAmount: widget.budget.spentAmount,
            expenseCap: double.parse(budgetController.text),
            dateStart: nowTimestamp,
            dateEnd: addDaysToTimestamp(
                int.parse(timeController.text), selectedTime));

        if (double.parse(budgetController.text) < spentAmount) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Vui lòng nhập ngân sách lớn hơn số tiền đã tiêu dùng cho giới hạn này: ' +
                    formatter.format(spentAmount),
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    fontSize: 16.fSize),
              ),
              duration: Duration(seconds: 2), // Thời gian hiển thị SnackBar
            ),
          );
        } else {
          addNewBudget(newBudget);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const BudgetView()));
        }
      } catch (e) {
        print("Error adding goal to Firestore: $e");
      }
    }
  }

  void fetchUserData(String userId) {
    FirebaseFirestore.instance
        .collection("users")
        .where("userId", isEqualTo: userId)
        .snapshots() // Sử dụng snapshots để lắng nghe thay đổi
        .listen((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        // Lấy dữ liệu từ querySnapshot
        double storedBalance =
            (querySnapshot.docs[0]['balance'] as num).toDouble();

        setState(() {
          balance = storedBalance;
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

    if (widget.budget.expenseCap == 0) {
      budgetController.text = "";
    } else {
      NumberFormat formatter = NumberFormat('000');

      budgetController.text = formatter.format(widget.budget.expenseCap);
    }
    fetchUserData(widget.budget.userId);
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
          IconButton(
              onPressed: () {
                addBudgetToFirestore();
              },
              icon: Icon(Icons.check, size: 30)),
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close, size: 30)),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(16.h, 19.v, 15.h, 0.v),
        padding: EdgeInsets.fromLTRB(20.h, 17.v, 24.h, 26.v),
        width: 359.h,
        height: 260.v,
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
                  CategoryIcon(imagePath: imagePath),
                  Container(
                    margin: EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0.h, 0.v, 0.h, 2.v),
                            child: Text(
                              categoryName,
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
              margin: EdgeInsets.only(left: 45.h),
              child: MyTextField(
                  width: 248,
                  hintText: AppLocalizations.of(context)!.budget,
                  controller: budgetController),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(61.h, 15.v, 5.h, 0.v),
              child: Row(
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
