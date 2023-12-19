import 'package:flutter/material.dart';
import 'package:budget_buddy/resources/app_export.dart';

class MyTextField extends StatelessWidget {
  final double width;
  final controller;
  final String hintText;
  const MyTextField(
      {super.key,
      required this.width,
      required this.hintText,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        child: TextField(
          style: TextStyle(
              fontSize: 13, fontWeight: FontWeight.w700, color: Colors.black),
          controller: controller,
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 13,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffcdcdcd)),
                  borderRadius: BorderRadius.circular(15)),
              filled: true,
              contentPadding: EdgeInsets.all(16)),
        ));
  }
}
