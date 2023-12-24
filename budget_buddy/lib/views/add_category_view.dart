import 'package:budget_buddy/data_sources/category_model.dart';
import 'package:budget_buddy/models/budget_model.dart';
import 'package:budget_buddy/presenters/budget_presenter.dart';
import 'package:budget_buddy/presenters/category_presenter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:budget_buddy/resources/app_export.dart';

class AddCategoryView extends StatefulWidget {
  MyCategory? existingCategory;
  AddCategoryView({super.key});
  AddCategoryView.existingCategory(MyCategory category, {super.key}) {
    existingCategory = category;
  }
  @override
  State<AddCategoryView> createState() => _AddCategoryViewState();
}

class _AddCategoryViewState extends State<AddCategoryView> {
  final CategoryPresenter _categoryPresenter = CategoryPresenter();
  final BudgetPresenter _budgetPresenter = BudgetPresenter();
  late String userID;
  bool _isIncome = true;
  TextEditingController _cName = TextEditingController();
  List<String> iconIPList = [
    "assets/images/restaurant.png",
    "assets/images/fuel.png",
    "assets/images/plane.png",
    "assets/images/shopping-bag.png",
    "assets/images/wages.png",
    "assets/images/plane.png",
    "assets/images/real_estate.png",
    "assets/images/smartphone.png",
    "assets/images/tablet.png",
  ];
  String _categoryIP = "assets/images/electricity-bill.png";
  @override
  void initState() {
    if (widget.existingCategory != null) {
      _cName.text = widget.existingCategory!.cName;
      _categoryIP = widget.existingCategory!.cImagePath;
      _isIncome = widget.existingCategory!.isIncome;
    }
    super.initState();
  }

  @override
  void dispose() {
    widget.existingCategory = null;
    super.dispose();
  }

  void _pressedAddCategory() {
    String uID = FirebaseAuth.instance.currentUser!.uid;
    String? cID;
    if (widget.existingCategory == null) {
      cID = FirebaseFirestore.instance.collection('categories').doc().id;
    } else {
      cID = widget.existingCategory!.categoryID;
    }

    if (_cName.value.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Vui lòng nhập tên loại chi tiêu!',
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                fontSize: 16.fSize),
          ),
          duration: Duration(seconds: 2), // Thời gian hiển thị SnackBar
        ),
      );
    } else {
      MyCategory newCategory = MyCategory(
          categoryID: cID,
          userID: uID,
          cName: _cName.value.text,
          cImagePath: _categoryIP,
          isIncome: _isIncome);
      addNewCategory(newCategory);

      if (widget.existingCategory == null) {
        if (_isIncome == false && cID != null) {
          DateTime now = DateTime.now();
          Timestamp nowTimestamp = Timestamp.fromDate(now);

          Budget newBudget = Budget(
              userId: uID,
              budgetId:
                  FirebaseFirestore.instance.collection('budgets').doc().id,
              categoryId: cID,
              spentAmount: 0,
              expenseCap: 0,
              dateStart: nowTimestamp,
              dateEnd: nowTimestamp);
          //Vì chưa tạo Budget nên chưa có ngày kết thúc
          _budgetPresenter.addBudget(
              newBudget,
              () => {},
              (error) => {
                    //Xu li loi
                  });
        }
      }
      print("Added new Category");
      Navigator.pop(context);
    }
  }

  void addNewCategory(MyCategory newCategory) {
    _categoryPresenter.addCategories(
        newCategory,
        () => {},
        (error) => {
              //Xu li loi
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white, size: 28.adaptSize),
          title: Text(
            AppLocalizations.of(context)!.categories_title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Color(0xff03a700),
          actions: [
            IconButton(icon: Icon(Icons.check), onPressed: _pressedAddCategory)
          ],
        ),
        body: Column(
          children: [
            Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Color(0xffDEDEDE),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 5.h,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(width: 1)),
                            padding: const EdgeInsets.all(10),
                            child: ImageIcon(
                              AssetImage(_categoryIP),
                              color: Colors.black,
                              size: 30,
                            ),
                          ),
                          SizedBox(width: 27.h),
                          Expanded(
                            child: TextField(
                              controller: _cName,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              obscureText: false,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                labelText: 'Category name',
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(width: 100),
                        Container(
                          padding: EdgeInsets.only(left: 10.h, right: 10.h),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.grey, width: 2.h),
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white),
                          child: DropdownButton(
                            underline: SizedBox(),
                            items: [
                              DropdownMenuItem(
                                  child: Text(AppLocalizations.of(context)!
                                      .categories_income),
                                  value: true),
                              DropdownMenuItem(
                                  child: Text(AppLocalizations.of(context)!
                                      .categories_outcome),
                                  value: false)
                            ],
                            value: _isIncome,
                            onChanged: (value) {
                              setState(() {
                                _isIncome = value!;
                              });
                            },
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.v),
                  ],
                )),
            Expanded(
              child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffDEDEDE),
                    border: Border(
                        top: BorderSide(
                            color: Theme.of(context).dividerColor, width: 2.h)),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.only(left: 16.h),
                          child: Text(
                              AppLocalizations.of(context)!
                                  .category_choose_icon,
                              style: TextStyle(
                                  fontSize: 15.fSize,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 20.h, right: 20.h, top: 10.v),
                          child: GridView.builder(
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 5,
                                      crossAxisSpacing: 25,
                                      mainAxisSpacing: 18),
                              itemCount: iconIPList.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        border: Border.all(width: 1)),
                                    child: IconButton(
                                      icon: Image.asset(iconIPList[index]),
                                      onPressed: () {
                                        setState(() {
                                          _categoryIP = iconIPList[index];
                                        });
                                      },
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ])),
            ),
          ],
        ));
  }
}
