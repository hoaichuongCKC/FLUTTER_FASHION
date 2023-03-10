import 'package:hydrated_bloc/hydrated_bloc.dart';

class KeyStorage {
  KeyStorage._();

  static const String token = "authenticated-token";

  static const String userAdress = "userr-address-";

  static String get getToken => HydratedBloc.storage.read(token);
}

// my_hydrated_storage.dart
