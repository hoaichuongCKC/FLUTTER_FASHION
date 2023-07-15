import 'package:flutter_fashion/core/base/exception/exception.dart';
import 'package:flutter_fashion/core/storage/key.dart';
import 'package:flutter_fashion/utils/alert/dialog.dart';

import '../../app/presentation/home/export.dart';

mixin HandlerErrorCubit<T> on Cubit<T> {
  void handlerError(BuildContext context, String error, T state) {
    if (error == AuthenticatedException.message) {
      showCustomDialog(
        context,
        barrierDismissible: false,
        content: error,
        title: "Token",
        submitNameSecond: AppLocalizations.of(context)!.ok,
        onSecond: () {
          HydratedBloc.storage.delete(KeyStorage.token);
          dispose();
          PusherBeamsApp.instance.dispose();
          AppRoutes.router.pop();
          AppRoutes.router.go(Routes.LOGIN);
        },
      );
    } else if (error == InternetException.message) {
      showErrorToast(error);
      return;
    }

    emit(state);
  }
}
