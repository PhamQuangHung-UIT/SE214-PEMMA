import 'package:flutter/material.dart';
import 'package:budget_buddy/resources/widget/category_icon.dart';
import 'package:budget_buddy/resources/app_export.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class AddNewEvent extends StatelessWidget {
  const AddNewEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffdedede),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'New Event',
            style: TextStyle(fontSize: 20.fSize, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(onPressed: () {}, icon: Icon(Icons.check, size: 30)),
          ],
          leading:
              IconButton(onPressed: () {}, icon: Icon(Icons.close, size: 30)),
        ),
        body: Container(
          margin: EdgeInsets.fromLTRB(16.h, 19.v, 16.h, 19.v),
          padding: EdgeInsets.fromLTRB(20.h, 17.v, 24.h, 26.v),
          width: 359.h,
          height: 274.v,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(7),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                offset: Offset(0.h, 4.v),
                blurRadius: 2,
              ),
            ],
          ),
          //Component
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0.h, 10.v, 0.h, 5.v),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0.h, 0.v, 13.h, 10.v),
                      padding: EdgeInsets.fromLTRB(8.h, 7.v, 8.h, 7.v),
                      height: 48.v,
                      width: 48.h,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(24.v)),
                      child: Center(
                          child: SizedBox(
                              child: Image.asset(
                        './assets/images/sort.png',
                        fit: BoxFit.cover,
                        width: 30.adaptSize,
                        height: 30.adaptSize,
                      ))),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0.h, 0.v, 5.h, 10.v),
                          child: SizedBox(
                            width: 220.h,
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Event name',
                                hintStyle: TextStyle(
                                  fontSize: 16.fSize,
                                  color: Colors.grey,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                filled: true,
                                contentPadding: EdgeInsets.all(16),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0.h, 10.v, 0.h, 5.v),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0.h, 0.v, 13.h, 10.v),
                                    padding:
                                        EdgeInsets.fromLTRB(8.h, 7.v, 8.h, 7.v),
                                    height: 48.v,
                                    width: 48.h,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(24.v)),
                                    child: Center(
                                        child: SizedBox(
                                            child: Image.asset(
                                      './assets/images/sort.png',
                                      fit: BoxFit.cover,
                                      width: 30.adaptSize,
                                      height: 30.adaptSize,
                                    ))),
                                  ),

                                  //Date
                                  Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0.h, 0.v, 13.h, 10.v),
                                      padding: EdgeInsets.fromLTRB(
                                          8.h, 7.v, 8.h, 7.v),
                                      height: 48.v,
                                      width: 100.h,
                                      decoration: BoxDecoration(
                                          border: null,
                                          borderRadius:
                                              BorderRadius.circular(24.v)),
                                      child: Center(
                                          child: TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          DateFormat('dd/MM/yyyy')
                                              .format(DateTime.now()),
                                          style: TextStyle(
                                              fontSize: 24.fSize,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black),
                                        ),
                                      ))),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0.h, 10.v, 0.h, 5.v),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0.h, 0.v, 13.h, 10.v),
                                    padding:
                                        EdgeInsets.fromLTRB(8.h, 7.v, 8.h, 7.v),
                                    height: 48.v,
                                    width: 48.h,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(24.v)),
                                    child: Center(
                                        child: SizedBox(
                                            child: Image.asset(
                                      './assets/images/sort.png',
                                      fit: BoxFit.cover,
                                      width: 30.adaptSize,
                                      height: 30.adaptSize,
                                    ))),
                                  ),

                                  //Date
                                  Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0.h, 0.v, 13.h, 10.v),
                                      padding: EdgeInsets.fromLTRB(
                                          8.h, 7.v, 8.h, 7.v),
                                      height: 48.v,
                                      width: 100.h,
                                      decoration: BoxDecoration(
                                          border: null,
                                          borderRadius:
                                              BorderRadius.circular(24.v)),
                                      child: Center(
                                          child: TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          ('ChooseColor'),
                                          style: TextStyle(
                                              fontSize: 24.fSize,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'Montserrat',
                                              color: Colors.black),
                                        ),
                                      ))),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
