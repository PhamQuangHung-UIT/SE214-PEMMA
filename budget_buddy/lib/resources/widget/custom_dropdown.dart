import 'package:flutter/material.dart';
import 'package:budget_buddy/resources/app_export.dart';

class CustomDropdown extends StatefulWidget {
  List<String> items;
  String? selectedItem;
  CustomDropdown({super.key, required this.items, required this.selectedItem});

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 14, right: 7),
      decoration: BoxDecoration(
          color: Color(0xfff5f5f5),
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: Color(0xffcdcdcd))),
      child: DropdownButton<String>(
          underline: Container(),
          value: widget.selectedItem,
          items: widget.items
              .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )))
              .toList(),
          onChanged: (time) => setState(() => widget.selectedItem = time)),
    );
  }
}
