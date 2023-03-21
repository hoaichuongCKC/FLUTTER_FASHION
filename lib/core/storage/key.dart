import 'package:hydrated_bloc/hydrated_bloc.dart';

class KeyStorage {
  KeyStorage._();

  static const String token = "authenticated-token";

  static const String userAdress = "user-address-";

  static const String userCart = "user-cart-";

  static String get getToken => HydratedBloc.storage.read(token);
}

// my_hydrated_storage.dart
