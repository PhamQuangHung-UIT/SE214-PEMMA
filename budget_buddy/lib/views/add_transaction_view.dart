import 'package:budget_buddy/data_sources/category_model.dart';
import 'package:budget_buddy/models/transaction_model.dart' as model;
import 'package:budget_buddy/presenters/budget_presenter.dart';
import 'package:budget_buddy/presenters/category_presenter.dart';
import 'package:budget_buddy/presenters/transaction_presenter.dart';
import 'package:budget_buddy/presenters/user_presenter.dart';
import 'package:budget_buddy/resources/widget/bottom_sheet_category.dart';
import 'package:budget_buddy/resources/widget/category_icon.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:budget_buddy/resources/app_export.dart';
import 'package:intl/intl.dart';

class AddTransactionView extends StatefulWidget {
  model.Transaction? existingTransaction;
  AddTransactionView({super.key});
  AddTransactionView.existingTransaction(model.Transaction transaction,
      {super.key}) {
    existingTransaction = transaction;
  }

  @override
  State<AddTransactionView> createState() => _AddTransactionViewState();
}

class _AddTransactionViewState extends State<AddTransactionView> {
  final CategoryPresenter _categoryPresenter = CategoryPresenter();
  final TransactionPresenter _transactionPresenter = TransactionPresenter();
  final UserPresenter _userPresenter = UserPresenter();
  final BudgetPresenter _budgetPresenter = BudgetPresenter();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  List<MyCategory> categoryList = [];
  List<MyCategory> cIncome = [];
  List<MyCategory> cOutcome = [];
  MyCategory selectedCategory =
      MyCategory(userID: "", cName: "", cImagePath: "", isIncome: false);

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  var formatter = NumberFormat('000');
  String date = "";
  String time = "";
  double balance = 0;
  String budgetId = "";
  String userID = "";
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        date = getFormattedDate(_selectedDate);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
        time = getFormattedTime(_selectedTime);
      });
    }
  }

  String getFormattedDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.year.toString().substring(2)}";
  }

  String getFormattedTime(TimeOfDay time) {
    return "${time.hour.toString().padLeft(2, '0')}:"
        "${time.minute.toString().padLeft(2, '0')}";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    date = getFormattedDate(_selectedDate);
    time = getFormattedTime(_selectedTime);
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userID = user.uid;
      _loadUserBalance(userID);
      _categoryPresenter.fetchCategories(
        userID,
        (categories) {
          setState(() {
            categoryList.clear();
            cIncome.clear();
            cOutcome.clear();
            categoryList.addAll(categories);
            for (int i = 0; i < categoryList.length; i++) {
              if (categoryList[i].isIncome) {
                cIncome.add(categoryList[i]);
              } else {
                cOutcome.add(categoryList[i]);
              }
            }
            if (widget.existingTransaction != null) {
              print('tồn tại transaction');
              for (int i = 0; i < categoryList.length; i++) {
                if (categoryList[i].categoryID ==
                    widget.existingTransaction?.categoryId) {
                  selectedCategory = categoryList[i];
                  break;
                }
              }
              _amountController.text =
                  formatter.format(widget.existingTransaction!.amount);
              date = widget.existingTransaction!.date;
              time = widget.existingTransaction!.time;
              _noteController.text = widget.existingTransaction!.note;
            } else {
              print('ko tồn tại transaction');
              print("categoryList length: " + categoryList.length.toString());
              if (categoryList.isEmpty == false) {
                selectedCategory = categoryList[0];
                print('selectedCatogory image path: ' +
                    selectedCategory.cImagePath);
              }
            }
          });
        },
        (error) {
          //error when fetching goals
        },
      );
    } else {
      //user not logged im
    }
  }

  //add transaction to firestore
  Future<void> addTransactionToFirestore() async {
    if (selectedCategory.cImagePath == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)!.no_category_available,
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                fontSize: 16.fSize),
          ),
          duration: Duration(seconds: 2), // Thời gian hiển thị SnackBar
        ),
      );
    } else {
      if (_amountController.value.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.please_enter_transaction_amount,
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
          String? tID;
          if (widget.existingTransaction == null) {
            tID =
                FirebaseFirestore.instance.collection('transactions').doc().id;
          } else {
            tID = widget.existingTransaction!.transactionId;
          }

          model.Transaction newTransaction = model.Transaction(
              userId: userId,
              transactionId: tID,
              categoryId: selectedCategory.categoryID,
              amount: double.parse(_amountController.text),
              date: date,
              time: time,
              note: _noteController.text);

          if (double.parse(_amountController.text) > balance &&
              !selectedCategory.isIncome) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  AppLocalizations.of(context)!.not_enough_balance,
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: 16.fSize),
                ),
                duration: Duration(seconds: 2), // Thời gian hiển thị SnackBar
              ),
            );
          } else {
            _transactionPresenter.addTransaction(newTransaction, () {
              Navigator.of(context, rootNavigator: true).pop();
            }, (p0) {
              debugPrint(p0);
            });

            //cap nhat xong
            if (widget.existingTransaction == null) {
              _userPresenter.updateUserBalanceAfterCreatingTransaction(
                  userId,
                  double.parse(_amountController.text),
                  selectedCategory.isIncome);

              _budgetPresenter.getBudgetIdWithCategoryId(
                userId,
                selectedCategory.categoryID,
                (budgetId) {
                  setState(() {
                    this.budgetId = budgetId;
                    _budgetPresenter.updateSpentAmount(
                        // cap nhat spent amount nếu đã có tạo giới hạn trước đó
                        budgetId,
                        double.parse(_amountController.text));
                    print("Loại chi tiêu: isIncome " +
                        selectedCategory.isIncome.toString());
                  });
                },
                (error) {
                  print("Error: $error");
                },
              );
            } else {
              double differentAmount = double.parse(_amountController.text) -
                  widget.existingTransaction!.amount;
              _userPresenter.updateUserBalanceAfterCreatingTransaction(
                  userId, differentAmount, selectedCategory.isIncome);

              _budgetPresenter.getBudgetIdWithCategoryId(
                userId,
                selectedCategory.categoryID,
                (budgetId) {
                  setState(() {
                    this.budgetId = budgetId;
                    _budgetPresenter.updateSpentAmount(
                        budgetId, differentAmount);
                    print("Loại chi tiêu: isIncome " +
                        selectedCategory.isIncome.toString());
                  });
                },
                (error) {
                  print("Error: $error");
                },
              );
            }

           // hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
          }
        } catch (e) {
          debugPrint(e.toString());
        }
      }
    }
  }

  void _selectCategoryAndCloseSheet(MyCategory category) {
    setState(() {
      selectedCategory = category;
    });
    Navigator.pop(context); // Đóng bottom sheet sau khi chọn category
  }

  void _showBottomSheetChooseCategory(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return DefaultTabController(
          length: 2,
          child: Container(
            height: 340.v,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TabBar(
                  labelColor: Color(0xff03A700),
                  indicatorColor: Color(0xff03A700),
                  unselectedLabelColor: Color(0xff5B5B5B),
                  tabs: [
                    Tab(text: AppLocalizations.of(context)!.categories_outcome),
                    Tab(text: AppLocalizations.of(context)!.categories_income),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      cOutcome.isEmpty
                          ? Center(
                              child: Text(
                                AppLocalizations.of(context)!.add_more_category,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            )
                          : ListView.builder(
                              itemCount: cOutcome.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.v),
                                  child: BottomSheetCategory(
                                    category: cOutcome[index],
                                    isSelected: cOutcome[index].categoryID ==
                                            selectedCategory.categoryID
                                        ? true
                                        : false,
                                    onTap: () {
                                      _selectCategoryAndCloseSheet(
                                          cOutcome[index]);
                                    },
                                  ),
                                );
                              },
                            ),
                      // BottomSheetCategory(
                      //     category: selectedCategory, isSelected: false),
                      cIncome.isEmpty
                          ? Center(
                              child: Text(
                                AppLocalizations.of(context)!.add_more_category,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            )
                          : ListView.builder(
                              itemCount: cIncome.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.v),
                                  child: BottomSheetCategory(
                                    category: cIncome[index],
                                    isSelected: cIncome[index].categoryID ==
                                            selectedCategory.categoryID
                                        ? true
                                        : false,
                                    onTap: () {
                                      _selectCategoryAndCloseSheet(
                                          cIncome[index]);
                                    },
                                  ),
                                );
                              },
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xffDEDEDE),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white, size: 28.adaptSize),
        title: Text(
          AppLocalizations.of(context)!.transaction_title,
          style: TextStyle(fontSize: 20.fSize, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xff03a700),
        actions: [
          IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                addTransactionToFirestore();
              })
        ],
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 88.v,
              width: double.infinity,
              decoration: BoxDecoration(color: Color(0xff03A700)),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              if (widget.existingTransaction == null) {
                                _showBottomSheetChooseCategory(context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Bạn không thể thay đổi loại chi tiêu',
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.fSize),
                                    ),
                                    duration: Duration(
                                        seconds:
                                            2), // Thời gian hiển thị SnackBar
                                  ),
                                );
                              }
                            },
                            child: CategoryIcon(
                                imagePath: selectedCategory.cImagePath)),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.only(top: 7.v),
                          child: SizedBox(
                            width: 280.h,
                            child: TextField(
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32.fSize,
                                ),
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.right,
                                cursorColor: Colors.white,
                                controller: _amountController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: AppLocalizations.of(context)!.amount_hint,
                                    hintStyle:
                                        TextStyle(color: Color(0xffC1C1C1)))),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.v,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 14.v,
            ),
            Container(
              height: 171.v,
              width: 359.h,
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
                padding: EdgeInsets.only(top: 17.v, left: 23.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 30.v,
                          width: 30.h,
                          child: Image.asset("assets/images/calendar.png"),
                        ),
                        SizedBox(
                          width: 16.h,
                        ),
                        GestureDetector(
                          onTap: () => _selectDate(context),
                          child: Text(
                            date,
                            style: TextStyle(
                                fontSize: 16.fSize,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 19.v,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 30.v,
                          width: 30.h,
                          child: Image.asset("assets/images/clock.png"),
                        ),
                        SizedBox(
                          width: 16.h,
                        ),
                        GestureDetector(
                          onTap: () => _selectTime(context),
                          child: Text(
                            time,
                            style: TextStyle(
                                fontSize: 16.fSize,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 12.v,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 30.v,
                          width: 30.h,
                          child: Image.asset("assets/images/notes.png"),
                        ),
                        SizedBox(
                          width: 16.h,
                        ),
                        Container(
                          width: 280.h,
                          child: TextField(
                              controller: _noteController,
                              style: TextStyle(
                                fontSize: 16.fSize,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff898989),
                              ),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: AppLocalizations.of(context)!
                                      .transaction_note_hint_text)),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ]),
    ));
  }
}
