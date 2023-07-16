import 'package:flutter_fashion/app/presentation/modules/user/home/export.dart';

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
          backgroundColor: background ?? blackColor,
          content: Row(
            children: [
              SvgPicture.asset("assets/icons/check_sucessfully.svg",
                  width: 18.0, height: 18.0),
              const SizedBox(width: 8.0),
              Text(
                content,
                style: PrimaryFont.instance.copyWith(
                  fontSize: 12.0,
                  color: textColor ?? lightColor,
                ),
              ),
            ],
          ),
          showCloseIcon: true,
          closeIconColor: background == lightColor ? blackColor : lightColor,
        ),
      );
  }
}
