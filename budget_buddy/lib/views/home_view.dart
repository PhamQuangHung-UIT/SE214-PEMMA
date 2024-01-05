import 'package:budget_buddy/data_sources/category_model.dart';
import 'package:budget_buddy/presenters/category_presenter.dart';
import 'package:budget_buddy/presenters/transaction_presenter.dart';
import 'package:budget_buddy/presenters/user_presenter.dart';
import 'package:budget_buddy/resources/app_export.dart';
import 'package:budget_buddy/resources/widget/home_category_item.dart';
import 'package:budget_buddy/resources/widget/transaction_tile.dart';
import 'package:budget_buddy/views/add_transaction_view.dart';
import 'package:budget_buddy/views/category_view.dart';
import 'package:budget_buddy/views/goal_budget_view.dart';
import 'package:budget_buddy/views/recent_transaction_view.dart';
import 'package:budget_buddy/models/transaction_model.dart' as model;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as Firebase;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:budget_buddy/models/user_model.dart' as User;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late User.User userData;
  final UserPresenter _userPresenter = UserPresenter();
  final TransactionPresenter _transactionPresenter = TransactionPresenter();
  final CategoryPresenter _categoryPresenter = CategoryPresenter();
  late NumberFormat formatter;
  late Stream<User.User> userDataStream;
  String fullName = "";
  double balance = 0;
  bool isVisible = false;
  List<model.Transaction> transactionList = [];

  List<MyCategory> categoryList = [];
  List<MyCategory> cIncome = [];
  List<MyCategory> cOutcome = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    isVisible = true;
    _loadUserData();
    String userId = FirebaseAuth.instance.currentUser!.uid;
    _transactionPresenter.fetchTransactions(
      userId,
      (transactions) {
        setState(() {
          transactionList.clear();
          transactionList.addAll(transactions);
        });
      },
      (error) {
        // Handle error when fetching goals
      },
    );
    _categoryPresenter.fetchCategories(
      userId,
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
        });
      },
      (error) {
        //error when fetching goals
      },
    );
  }

  void _loadUserData() async {
    Firebase.User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      try {
        _userPresenter.listenUserData(
          userId,
          (User.User user) {
            // Xử lý dữ liệu người dùng nhận được
            setState(() {
              userData = user;
              fullName = userData.fullname;
              balance = userData.balance.toDouble();
              var currencyLanguage = user.currency == 'VND' ? 'vi' : 'en';
              formatter = NumberFormat.simpleCurrency(locale: currencyLanguage);
              isLoading = false;
            });
          },
          (String error) {
            // Xử lý lỗi
          },
        );
      } catch (e) {
        print("Error: $e");
        throw e;
      }
    } else {
      throw 'User not found';
    }
  }

  void _toggleVisibility() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
          body: Center(
              child: CircularProgressIndicator(color: AppTheme.green800)));
    }
    return SafeArea(
        child: DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: Colors.white,
          body:
              // Lấy thông tin từ snapshot và hiển thị lên các Text
              SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 38.h, vertical: 28.v),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('👋 ${AppLocalizations.of(context)!.hello}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.fSize,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 5.v,
                            ),
                            Text(
                              fullName,
                              style: TextStyle(
                                  fontSize: 20.fSize,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AddTransactionView()));
                          },
                          child: Image.asset(
                            'assets/images/bell.png',
                            width: 25.adaptSize,
                            height: 25.adaptSize,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 15.v),
                    Container(
                      width: double.infinity,
                      height: 95.v,
                      decoration: BoxDecoration(
                        color: Color(0xff03a700),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x3f000000),
                            blurRadius: 2,
                            offset: Offset(0, 4),
                          )
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 18.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.balance,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 5.v,
                            ),
                            Row(
                              children: [
                                Text(
                                  isVisible == true
                                      ? formatter.format(balance)
                                      : "••••••••••••",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(
                                          color: Colors.white, fontSize: 24),
                                ),
                                SizedBox(
                                  width: 8.h,
                                ),
                                SizedBox(
                                  height: 27.v,
                                  width: 27.h,
                                  child: GestureDetector(
                                    onTap: () {
                                      _toggleVisibility();
                                    },
                                    child: Image.asset(isVisible == true
                                        ? "assets/images/visible.png"
                                        : "assets/images/hidden.png"),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.recent_transaction,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RecentTransaction()));
                          },
                          child: Text(
                            AppLocalizations.of(context)!.view_all,
                            style: TextStyle(
                                color: Color(0xff03a700),
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8.v,
                    ),
                    Container(
                      width: double.infinity,
                      height: 200.h,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0x3f000000),
                                offset: Offset(0, 0),
                                blurRadius: 2,
                                spreadRadius: 2)
                          ]),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: transactionList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.h, vertical: 8.v),
                            child: TransactionTile(
                                transaction: transactionList[index]),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15.v,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.categories_title,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context, rootNavigator: true).push(
                                MaterialPageRoute(
                                    builder: (_) =>
                                        const CategoryView()));
                          },
                          child: Text(
                            AppLocalizations.of(context)!.view_all,
                            style: TextStyle(
                                color: Color(0xff03a700),
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8.v,
                    ),
                    Container(
                        width: double.infinity,
                        height: 250.h,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0x3f000000),
                                  offset: Offset(0, 0),
                                  blurRadius: 2,
                                  spreadRadius: 2)
                            ]),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 8.h, right: 8.h, top: 10.v),
                              child: TabBar(
                                unselectedLabelColor: Color(0xff5B5B5B),
                                indicator: BoxDecoration(
                                    color: AppTheme.green800,
                                    borderRadius: BorderRadius.circular(8)),
                                tabs: [
                                  Tab(
                                      text: AppLocalizations.of(context)!
                                          .categories_outcome),
                                  Tab(
                                      text: AppLocalizations.of(context)!
                                          .categories_income),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 200.v,
                              child: TabBarView(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.h,
                                    ),
                                    child: Container(
                                      child: cOutcome.isEmpty
                                          ? Center(
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .add_more_category,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            )
                                          : ListView.builder(
                                              itemCount: cOutcome.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10.v),
                                                    child: HomeCategoryItem(
                                                        category:
                                                            cOutcome[index]));
                                              },
                                            ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.h),
                                    child: Container(
                                      child: cIncome.isEmpty
                                          ? Center(
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .add_more_category,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            )
                                          : ListView.builder(
                                              itemCount: cIncome.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10.v),
                                                    child: HomeCategoryItem(
                                                        category:
                                                            cIncome[index]));
                                              },
                                            ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        )),
                  ],
                ), //ROOT COLUMN
              ),
            ),
          )),
    ));
  }
}
