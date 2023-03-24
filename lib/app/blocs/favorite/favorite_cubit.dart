import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_fashion/app/blocs/user/user_cubit.dart';
import 'package:flutter_fashion/app/models/product/product.dart';
import 'package:flutter_fashion/app/presentation/login/export.dart';
import 'package:flutter_fashion/core/storage/key.dart';
part 'favorite_state.dart';

class FavoriteCubit extends HydratedCubit<FavoriteState> {
  FavoriteCubit() : super(const FavoriteState());

  @override
  String get storageToken =>
      KeyStorage.userFavorite + getIt.get<UserCubit>().user.id.toString();

  void addFavorite(ProductModel product) {
    final state = this.state;
    final list = state.listProduct;
    final updatedList = [...list, product];
    emit(state.copyWith(listProduct: updatedList));
  }

  @override
  FavoriteState? fromJson(Map<String, dynamic> json) {
    log("json: ${json["data"]}", name: "Favorite Json");
    return json["data"] == null
        ? const FavoriteState()
        : FavoriteState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(FavoriteState state) {
    log("state: ${state.listProduct}");
    return state.toJson();
  }
}
