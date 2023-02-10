import 'package:flutter/material.dart';
import 'package:flutter_fashion/app/config/colors.dart';
import 'package:flutter_fashion/app/config/constant.dart';

ThemeData appTheme = ThemeData(
  primaryColor: primaryColor,
  brightness: Brightness.light,
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    backgroundColor: scaffoldBackgroundColor,
    centerTitle: true,
    elevation: 0.0,
    iconTheme: IconThemeData(
      size: 18.0,
      color: Colors.black87,
    ),
    toolbarTextStyle: TextStyle(
      color: Colors.black87,
      fontSize: 20.0,
    ),
  ),
  scaffoldBackgroundColor: scaffoldBackgroundColor,
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: lightColor,
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(
        Radius.circular(radiusBtn),
      ),
    ),
  ),
);
