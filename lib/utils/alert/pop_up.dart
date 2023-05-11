import 'package:flutter_fashion/export.dart';

popupAlert({
  required BuildContext context,
  String message = "Come on bro",
  Function()? onPressed,
  Function()? onCancel,
  bool noButtonCancle = false,
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
      final width = MediaQuery.of(context).size.width * .8;
      final theme = Theme.of(context);
      return Center(
        child: Material(
          borderRadius: const BorderRadius.all(Radius.circular(14.0)),
          child: SizedBox(
            width: width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DecoratedBox(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radiusBtn),
                        topRight: Radius.circular(radiusBtn)),
                    color: primaryColor,
                  ),
                  child: SizedBox(
                    width: width,
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
                          style: theme.textTheme.bodyMedium!
                              .copyWith(fontSize: 14.0),
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
                                noButtonCancle
                                    ? const SizedBox()
                                    : InkWell(
                                        onTap: onCancel ??
                                            () {
                                              AppRoutes.router.pop();
                                              AppRoutes.router.pop();
                                            },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Align(
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .cancel,
                                              style: theme.textTheme.bodySmall!
                                                  .copyWith(
                                                color: primaryColor
                                                    .withOpacity(0.5),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                noButtonCancle
                                    ? const SizedBox()
                                    : const SizedBox(width: 15.0),
                                InkWell(
                                  onTap: onPressed,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                      child: Text(
                                        AppLocalizations.of(context)!.ok,
                                        style:
                                            theme.textTheme.bodySmall!.copyWith(
                                          color: primaryColor,
                                          fontWeight: FontWeight.w600,
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

popupTextAlert({
  required BuildContext context,
  String message = "Come on bro",
  bool hasTimer = true,
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
    barrierColor: Colors.transparent,
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
          color: const Color(0x80000000),
          surfaceTintColor: const Color(0x80000000),
          borderRadius: const BorderRadius.all(Radius.circular(radiusBtn)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              message,
              style: PrimaryFont.instance.copyWith(
                fontSize: 14.0,
                color: lightColor,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
      );
    },
  );
}
