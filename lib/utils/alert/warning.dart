import 'package:flutter_fashion/export.dart';

warningAlert(
    {required BuildContext context,
    String message = "Come on bro",
    required Function() onPressed}) async {
  await showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "warning - Alert",
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
                    color: warningColor,
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
                      const SizedBox(height: 10.0),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ButtonWidget(
                          height: 40,
                          width: 60,
                          animate: false,
                          onPressed: () {
                            AppRoutes.router.pop();
                            onPressed();
                          },
                          btnColor: primaryColor,
                          labelWidget: Align(
                            child: Text(
                              AppLocalizations.of(context)!.gotIt,
                              style: PrimaryFont.instance.copyWith(
                                fontSize: 12.0,
                                color: lightColor,
                              ),
                            ),
                          ),
                        ),
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
