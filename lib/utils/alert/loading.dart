import 'package:flutter/material.dart';
import 'package:flutter_fashion/config/constant.dart';

import '../../config/colors.dart';

loadingAlert({required BuildContext context}) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return const Dialog(
        surfaceTintColor: lightColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(radiusBtn))),
        child: SizedBox(
          height: 150.0,
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    },
  );
}
