import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showErrorToast(String msg,
    {ToastGravity? gravity = ToastGravity.TOP,
    Toast? toastLength = Toast.LENGTH_LONG}) {
  Fluttertoast.showToast(
    msg: msg,
    textColor: darkColor,
    backgroundColor: disablePrimaryColor,
    gravity: gravity,
    fontSize: 14.0,
    toastLength: toastLength,
  );
}

void showSuccessToast(String msg,
    {ToastGravity? gravity = ToastGravity.TOP,
    Toast? toastLength = Toast.LENGTH_LONG}) {
  Fluttertoast.showToast(
    msg: msg,
    textColor: darkColor,
    backgroundColor: successfullyColor,
    gravity: gravity,
    fontSize: 14.0,
    toastLength: toastLength,
  );
}
