import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fashion/config/colors.dart';
import 'package:flutter_fashion/config/constant.dart';
import 'package:flutter_svg/svg.dart';

import '../../routes/app_routes.dart';

void errorAlert(
    {required BuildContext context,
    String message = "Nani",
    int counter = 2}) async {
  const Duration duration = Duration(seconds: 1);
  Timer.periodic(duration, (timer) {
    if (timer.tick == counter) {
      timer.cancel();
      AppRoutes.router.pop();
    }
  });

  await showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierLabel: "Alert - error",
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return AnimatedOpacity(
          opacity: animation.value,
          duration: const Duration(milliseconds: 450),
          curve: Curves.easeIn,
          child: child);
    },
    pageBuilder: (newCtx, a1, a2) {
      return Center(
        child: Material(
          color: lightColor,
          surfaceTintColor: lightColor,
          borderRadius: const BorderRadius.all(Radius.circular(14.0)),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * .8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DecoratedBox(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(14.0),
                        topRight: Radius.circular(14.0)),
                    color: errorColor,
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * .8,
                    height: 14.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: verticalPadding - 4,
                      horizontal: horizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                        child: SvgPicture.asset("assets/icons/error.svg"),
                      ),
                      const SizedBox(height: 8.0),
                      Align(
                        child: Text(
                          message,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 14.0,
                                    color: darkColor,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
