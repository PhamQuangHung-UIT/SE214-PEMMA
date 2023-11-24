import 'package:budget_buddy/resources/app_export.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.lightTheme.colorScheme.background,
        body: SafeArea(
            child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 100.0),
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Hello, user',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 80,
                            fontWeight: FontWeight.bold)),
                    Image.asset(
                      'assets/images/bell.png',
                      width: 30.adaptSize,
                      height: 30.adaptSize,
                    )
                  ],
                )),
            const SizedBox(height: 10),
            Container(
                padding: EdgeInsets.all(70),
                decoration: BoxDecoration(
                  color: AppTheme.green800,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 15,
                      offset: Offset(0, 15),
                    )
                  ],
                ),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  runSpacing: 20,
                  children: [
                    Text(
                      'BALANCE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Wrap(spacing: 50, children: [
                      Text(
                        '9,999,999 VND',
                        style: TextStyle(color: Colors.white, fontSize: 80),
                      ),
                      Image.asset(
                        'assets/images/visible.png',
                        width: 80,
                        height: 80,
                      )
                    ]),
                    Divider(
                      color: Colors.white,
                      thickness: 2,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(spacing: 50, children: [
                          //number
                          Text(
                            '6',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 50,
                            ),
                          ),
                          Text(
                            'Expenses',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 50,
                            ),
                          ),
                          Image.asset('assets/images/plus-1.png',
                              width: 55, height: 55),
                        ]),
                        Wrap(spacing: 50, children: [
                          //number
                          Text(
                            '1',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 50,
                            ),
                          ),
                          Text(
                            'Expense caps',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 50,
                            ),
                          ),
                          Image.asset('assets/images/plus-1.png',
                              width: 55, height: 55),
                        ]),
                        Wrap(spacing: 50, children: [
                          //number
                          Text(
                            '2',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 50,
                            ),
                          ),
                          Text(
                            'Goals',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 50,
                            ),
                          ),
                          Image.asset(
                            'assets/images/plus-1.png',
                            width: 55,
                            height: 55,
                          ),
                        ])
                      ],
                    )
                  ],
                )),
            const SizedBox(height: 100),
            Align(
                alignment: Alignment.centerLeft,
                child: Text('Expense Report', style: TextStyle(fontSize: 50))),
            const SizedBox(height: 50),
            Container(
              width: 900,
              height: 500,
              padding: EdgeInsets.all(50),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 15,
                  )
                ],
              ),
            ),
            const SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent transactions',
                    style: TextStyle(color: Colors.black, fontSize: 50)),
                GestureDetector(
                    //onTap: *insert method here*,
                    child: Text(
                  'View all',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 40,
                  ),
                ))
              ],
            ),
            const SizedBox(height: 50),
            Container(
                padding: EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 15,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Container(
                              padding: EdgeInsets.all(20),
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child:
                                  Image.asset('assets/images/restaurant.png'),
                            )),
                        Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Food',
                                    style: TextStyle(
                                      fontSize: 40,
                                      color: Colors.black,
                                    )),
                                Text('Oct 6 2023',
                                    style: TextStyle(
                                      fontSize: 35,
                                      color: Colors.blue,
                                    ))
                              ],
                            )),
                        Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('\"October groceries\"',
                                    style: TextStyle(
                                        fontSize: 35,
                                        color: Colors.grey,
                                        overflow: TextOverflow.ellipsis)),
                                Text('-500,000',
                                    style: TextStyle(
                                        fontSize: 35, color: Colors.red))
                              ],
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Container(
                              padding: EdgeInsets.all(20),
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Image.asset('assets/images/fuel.png'),
                            )),
                        Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Gas',
                                    style: TextStyle(
                                      fontSize: 40,
                                      color: Colors.black,
                                    )),
                                Text('Oct 6 2023',
                                    style: TextStyle(
                                      fontSize: 35,
                                      color: Colors.blue,
                                    ))
                              ],
                            )),
                        Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('',
                                    style: TextStyle(
                                        fontSize: 35,
                                        color: Colors.grey,
                                        overflow: TextOverflow.ellipsis)),
                                Text('-250,000',
                                    style: TextStyle(
                                        fontSize: 35, color: Colors.red))
                              ],
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Container(
                              padding: EdgeInsets.all(20),
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Image.asset('assets/images/salary.png'),
                            )),
                        Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Salary',
                                    style: TextStyle(
                                      fontSize: 40,
                                      color: Colors.black,
                                    )),
                                Text('Oct 5 2023',
                                    style: TextStyle(
                                      fontSize: 35,
                                      color: Colors.blue,
                                    ))
                              ],
                            )),
                        Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('\"September Salary\"',
                                    style: TextStyle(
                                        fontSize: 35,
                                        color: Colors.grey,
                                        overflow: TextOverflow.ellipsis)),
                                Text('+10,000,000',
                                    style: TextStyle(
                                        fontSize: 35, color: Colors.green))
                              ],
                            )),
                      ],
                    )
                  ],
                )),
          ],
        )));
  }
}
