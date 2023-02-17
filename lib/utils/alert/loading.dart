import 'package:flutter/material.dart';

loadingAlert({required BuildContext context}) async {
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
