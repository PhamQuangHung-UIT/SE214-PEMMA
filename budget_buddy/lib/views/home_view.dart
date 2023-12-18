import 'dart:ffi';

import 'package:budget_buddy/resources/app_export.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late Future<DocumentSnapshot<Map<String, dynamic>>?> userData;
  var formatter = NumberFormat('#,000');
  bool isVisible = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userData = fetchUserData();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>?> fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        String userId = user.uid;
        QuerySnapshot<Map<String, dynamic>> querySnapshot =
            await FirebaseFirestore.instance
                .collection('users')
                .where('userId', isEqualTo: userId)
                .limit(1)
                .get();

        if (querySnapshot.size > 0) {
          return querySnapshot.docs.first;
        } else {
          throw 'No matching document found';
        }
      } catch (e) {
        throw e;
      }
    }
    return null;
  }

  void _toggleVisibility() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>?>(
                future: userData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return Center(child: Text('No data available'));
                  } else {
                    // Lấy thông tin từ snapshot và hiển thị lên các Text
                    var userData =
                        snapshot.data!.data() as Map<String, dynamic>?;
                    if (userData != null) {
                      String fullName = userData['fullname'];
                      int balance = userData['balance'];

                      return SafeArea(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 38.h, vertical: 28.v),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            '👋 ' +
                                                AppLocalizations.of(context)!
                                                    .hello,
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
                                    Image.asset(
                                      'assets/images/bell.png',
                                      width: 25.adaptSize,
                                      height: 25.adaptSize,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                                  ? formatter.format(balance) +
                                                      " " +
                                                      AppLocalizations.of(
                                                              context)!
                                                          .currency_icon
                                                  : "••••••••••••",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w500),
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
                                                child: Image.asset(isVisible ==
                                                        true
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!
                                          .recent_transaction,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.view_all,
                                      style: TextStyle(
                                          color: Color(0xff03a700),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
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
                                  child: SizedBox(),
                                ),
                                SizedBox(
                                  height: 15.v,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!
                                          .categories_title,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.view_all,
                                      style: TextStyle(
                                          color: Color(0xff03a700),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 8.v,
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 300.h,
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
                                  child: SizedBox(),
                                ),
                              ],
                            ), //ROOT COLUMN
                          ),
                        ),
                      );
                    }
                    return Container();
                  }
                })));
  }
}
