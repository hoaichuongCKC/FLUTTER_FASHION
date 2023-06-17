import 'package:hydrated_bloc/hydrated_bloc.dart';

class KeyStorage {
  KeyStorage._();

  static const String token = "authenticated-token";

  static const String userAdress = "user-address-";

  static const String userCart = "user-cart-";

  static const String userFavorite = "user-favorite-";

  static const String userLanguage = "user-language-";

  static const String userSearch = "user-search-";

  static const String userCancelOrder = "user-cancel-order-";

  static const String notification = "user-notification-";

  static String get getToken => HydratedBloc.storage.read(token);
}

// my_hydrated_storage.dart
