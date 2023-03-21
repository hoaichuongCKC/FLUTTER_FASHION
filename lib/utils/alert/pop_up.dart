import 'package:flutter_fashion/export.dart';

popupAlert({
  required BuildContext context,
  String message = "Come on bro",
  Function()? onPressed,
  Function()? onCancel,
  bool hasTimer = false,
  int counter = 2,
}) async {
  if (hasTimer) {
    const Duration duration = Duration(seconds: 1);
    Timer.periodic(duration, (timer) {
      if (timer.tick == counter) {
        timer.cancel();
        AppRoutes.router.pop();
      }
    });
  }
  await showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierLabel: "popup - Alert",
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
                    color: primaryColor,
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
                      const SizedBox(height: 10.0),
                      Align(
                        child: Text(
                          message,
                          style: PrimaryFont.instance.copyWith(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      hasTimer
                          ? const SizedBox()
                          : const SizedBox(height: 15.0),
                      hasTimer
                          ? const SizedBox()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ButtonWidget(
                                  height: 30,
                                  width: 60,
                                  animate: false,
                                  onPressed: onCancel ??
                                      () {
                                        AppRoutes.router.pop();
                                        AppRoutes.router.pop();
                                      },
                                  btnColor: disablePrimaryColor,
                                  labelWidget: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Align(
                                      child: Text(
                                        AppLocalizations.of(context)!.cancel,
                                        style: PrimaryFont.instance.copyWith(
                                          fontSize: 12.0,
                                          color: lightColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15.0),
                                ButtonWidget(
                                  height: 30,
                                  width: 60,
                                  animate: false,
                                  onPressed: onPressed,
                                  btnColor: primaryColor,
                                  labelWidget: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Align(
                                      child: Text(
                                        AppLocalizations.of(context)!.ok,
                                        style: PrimaryFont.instance.copyWith(
                                          fontSize: 12.0,
                                          color: lightColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
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
