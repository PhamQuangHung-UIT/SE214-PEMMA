import 'package:flutter/material.dart';
import 'package:budget_buddy/resources/app_export.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:budget_buddy/resources/widget/category_icon.dart';

//
import 'package:budget_buddy/resources/widget/category_icon.dart';

class MainEventView extends StatefulWidget {
  const MainEventView({super.key});

  @override
  State<MainEventView> createState() => _MainEventViewState();
}

class _MainEventViewState extends State<MainEventView> {
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
        //
        body: Container(
          padding: EdgeInsets.fromLTRB(56.h, 17.v, 72.h, 1.v),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(17.h, 0.v, 0.h, 9.v),
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //Calendar
                    Center(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0.h, 0.v, 119.h, 0.v),
                        child: Text(
                          'Calendar',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            // 'Montserrat',
                            fontSize: 14.fSize,
                            fontWeight: FontWeight.w700,
                            height: 1.2175.v,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                    ),
                    //Event list
                    Center(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0.h, 0.v, 119.h, 0.v),
                        child: Text(
                          'Event list',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            // 'Montserrat',
                            fontSize: 14.fSize,
                            fontWeight: FontWeight.w700,
                            height: 1.2175.v,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            //Calendar
          ),
        ),
      ),
    );
  }
}
