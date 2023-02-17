import 'package:flutter/material.dart';
import 'package:flutter_fashion/config/colors.dart';
import 'package:flutter_fashion/config/font_style.dart';

class AppSnackbarMessenger {
  AppSnackbarMessenger._();

  static GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static void showMessage({required String content}) {
    scaffoldMessengerKey.currentState!
      ..removeCurrentMaterialBanner()
      ..showMaterialBanner(
        MaterialBanner(
          overflowAlignment: OverflowBarAlignment.end,
          backgroundColor: disablePrimaryColor,
          content: Text(content),
          leading:
              Image.asset("assets/images/admin.png", width: 32, height: 32),
          contentTextStyle: PrimaryFont.instance.copyWith(
              fontSize: 13.0, color: darkColor, fontWeight: FontWeight.w300),
          actions: [
            InkWell(
                onTap: () => scaffoldMessengerKey.currentState!
                    .removeCurrentMaterialBanner(),
                child: const Icon(Icons.close)),
          ],
        ),
      );
  }
}
