import 'package:flutter/material.dart';
import 'package:flutter_fashion/config/colors.dart';
import 'package:flutter_fashion/config/constant.dart';
import 'package:flutter_fashion/config/font_style.dart';

ThemeData appThemeLight = ThemeData(
  primaryColor: primaryColor,
  brightness: Brightness.light,
  useMaterial3: true,
  buttonTheme: const ButtonThemeData(
    buttonColor: primaryColor,
  ),
  textTheme: TextTheme(
    titleSmall: PrimaryFont.instance.copyWith(
      fontSize: 25.0,
      color: darkColor,
      fontWeight: FontWeight.w500,
      height: 1.5,
    ),
    bodySmall: PrimaryFont.instance.copyWith(
      fontSize: 12.0,
      color: darkColor,
      height: 1.5,
      fontWeight: FontWeight.w300,
    ),
    bodyMedium: PrimaryFont.instance.copyWith(
      fontSize: 16.0,
      color: darkColor,
      height: 1.5,
      fontWeight: FontWeight.w300,
    ),
    bodyLarge: PrimaryFont.instance.copyWith(
      fontSize: 18.0,
      color: darkColor,
      height: 1.5,
      fontWeight: FontWeight.w300,
    ),
  ),
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

ThemeData appThemeDark = ThemeData(
  primaryColor: primaryColor,
  textTheme: TextTheme(
    titleSmall: PrimaryFont.instance.copyWith(
      fontSize: 25.0,
      color: lightColor,
      fontWeight: FontWeight.w500,
      height: 1.5,
    ),
    bodySmall: PrimaryFont.instance.copyWith(
      fontSize: 12.0,
      color: lightColor,
      height: 1.5,
      fontWeight: FontWeight.w300,
    ),
    bodyMedium: PrimaryFont.instance.copyWith(
      fontSize: 16.0,
      color: lightColor,
      height: 1.5,
      fontWeight: FontWeight.w300,
    ),
    bodyLarge: PrimaryFont.instance.copyWith(
      fontSize: 18.0,
      color: lightColor,
      height: 1.5,
      fontWeight: FontWeight.w300,
    ),
  ),
  brightness: Brightness.dark,
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    backgroundColor: darkColor,
    centerTitle: true,
    elevation: 0.0,
    iconTheme: IconThemeData(
      size: 18.0,
      color: Colors.white,
    ),
    toolbarTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
    ),
  ),
  scaffoldBackgroundColor: darkColor,
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
