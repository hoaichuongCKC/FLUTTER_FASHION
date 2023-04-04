import 'package:flutter/material.dart';
import 'package:flutter_fashion/config/colors.dart';
import 'package:flutter_fashion/config/font_style.dart';

class AppSnackbarMessenger {
  AppSnackbarMessenger._();

  static GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static void showMessage(
      {required String content, Color? background, Color? textColor}) {
    scaffoldMessengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          dismissDirection: DismissDirection.startToEnd,
          backgroundColor: background ?? darkColor,
          content: Text(
            content,
            style: PrimaryFont.instance.copyWith(
              fontSize: 12.0,
              color: textColor ?? lightColor,
            ),
          ),
          showCloseIcon: true,
          closeIconColor: background == lightColor ? darkColor : lightColor,
        ),
      );
  }
}
