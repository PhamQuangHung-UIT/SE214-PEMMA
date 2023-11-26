import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class event_main extends StatelessWidget {
  const event_main({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            padding: EdgeInsets.all(20),
            width: 359,
            height: 196,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Write something",
                  ),
                ),
                Icon(Icons.abc_sharp),
                Icon(Icons.abc_sharp),
                Text("End on"),
                Text("Choose color"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
