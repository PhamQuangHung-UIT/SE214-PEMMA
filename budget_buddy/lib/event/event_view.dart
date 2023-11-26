import 'package:budget_buddy/event/event_main.dart';
import 'package:flutter/material.dart';
import 'package:budget_buddy/responsive_padding.dart';

class Event_view extends StatefulWidget {
  const Event_view({super.key});

  @override
  State<Event_view> createState() => _Event_viewState();
}

class _Event_viewState extends State<Event_view> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Event"),
        elevation: 0,
        backgroundColor: Colors.green,
        leading: Icon(Icons.arrow_back_sharp),
      ),

      //Add button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => event_main(),
            ),
          );
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
      ),

      //
    );
  }
}
