import 'package:budget_buddy/resources/utils/size_utils.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static const green800 = Color(0xFF03A700);

  static final grey400 = Colors.grey.shade400;

  static const grey300 = Color(0XFFDEDEDE);

  static var lightTheme = ThemeData(
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: green800,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.h),
          ),
          shadowColor: colorScheme.primary,
          elevation: 4,
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
          textStyle: textTheme.labelLarge!.copyWith(color: Colors.white)
        ),
      ),
      dividerTheme: DividerThemeData(
        thickness: 1,
        space: 1,
        color: grey400,
      ),
      colorScheme: colorScheme,
      textTheme: textTheme
    );

  static final colorScheme = ColorScheme.fromSwatch(
    primarySwatch: Colors.green, 
    backgroundColor: Colors.white, 
    accentColor: Colors.black87, 
    errorColor: Colors.red);

  static final TextTheme textTheme = TextTheme(
      bodyLarge: TextStyle(
        color: Colors.black,
        fontSize: 18.fSize,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
        color: Colors.black,
        fontSize: 14.fSize,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w400,
      ),
      headlineLarge: TextStyle(
        color: Colors.black,
        fontSize: 30.fSize,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w700,
      ),
      headlineMedium: TextStyle(
        color: Colors.black,
        fontSize: 26.fSize,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w500,
      ),
      headlineSmall: TextStyle(
        color: Colors.black,
        fontSize: 20.fSize,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w600,
      ),
      labelLarge: TextStyle(
        color: grey400,
        fontSize: 14.fSize,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w600,
      ),
      labelMedium: TextStyle(
        color: Colors.black87,
        fontSize: 12.fSize,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w400,
      ),
      titleLarge: TextStyle(
        color: Colors.black87,
        fontSize: 20.fSize,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w400,
      ),
      titleMedium: TextStyle(
        color: grey400,
        fontSize: 18.fSize,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w700,
      ),
      titleSmall: TextStyle(
          color: Colors.black87,
          fontSize: 14.fSize,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w500,
        ),
    );
}
