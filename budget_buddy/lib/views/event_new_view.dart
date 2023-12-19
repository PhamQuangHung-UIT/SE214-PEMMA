import 'package:flutter/material.dart';
import 'package:budget_buddy/resources/app_export.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:budget_buddy/resources/widget/category_icon.dart';

//
import 'package:budget_buddy/resources/widget/category_icon.dart';

class AddEventView extends StatefulWidget {
  const AddEventView({super.key});

  @override
  State<AddEventView> createState() => _AddEventViewState();
}

class _AddEventViewState extends State<AddEventView> {
  final eventController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffdedede),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)!.add_event_title,
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
          margin: EdgeInsets.fromLTRB(16.h, 30.v, 15.h, 0.v),
          padding: EdgeInsets.fromLTRB(20.h, 30.v, 24.h, 26.v),
          width: 359.h,
          height: 320.v,
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
                    CategoryIcon(imagePath: "assets/images/calendar.png"),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0.h, 0.v, 5.h, 10.v),
                          child: SizedBox(
                            width: 220.h,
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: AppLocalizations.of(context)!
                                    .add_event_title,
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CategoryIcon(
                                      imagePath: "assets/images/calendar.png"),

                                  //Date
                                  Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0.h, 0.v, 12.h, 10.v),
                                      padding: EdgeInsets.fromLTRB(
                                          0.h, 0.v, 0.h, 0.v),
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

                                  //end date time
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                CategoryIcon(
                                    imagePath: "assets/images/calendar.png"),
                                Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0.h, 0.v, 12.h, 10.v),
                                    padding:
                                        EdgeInsets.fromLTRB(0.h, 0.v, 0.h, 0.v),
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
