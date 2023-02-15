import 'package:flutter/material.dart';
import 'package:flutter_fashion/utils/alert/control.dart';

import '../../routes/app_routes.dart';

loadingAlert({required BuildContext context}) {
  if (AlertControl.instance.isHasAlert) {
    debugPrint("isHasAlert loading: ${AlertControl.instance.isHasAlert}");
    AppRoutes.pop();
  }
  AlertControl.instance.updateShow();
  showGeneralDialog(
    context: context,
    barrierDismissible: false,
    pageBuilder: (newCtx, a1, a2) {
      return const Center(
        child: Material(
          color: Colors.transparent,
          child: CircularProgressIndicator(),
        ),
      );
    },
  );
}
