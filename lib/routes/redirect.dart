import 'dart:developer';

import 'package:flutter_fashion/core/storage/key.dart';

import '../app/blocs/user/user_cubit.dart';
import '../export.dart';

String? redirectHome(context) {
  String? isAuthenticated = HydratedBloc.storage.read(KeyStorage.token);

  log("Your Token: $isAuthenticated", name: "Local storage");

  if (isAuthenticated != null) {
    BlocProvider.of<UserCubit>(context).fetchUser(context);

    return Routes.HOME;
  }
  return null;
}
