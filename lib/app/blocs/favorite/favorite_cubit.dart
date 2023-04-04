// ignore_for_file: invalid_override_of_non_virtual_member
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

  void removeFavorite(ProductModel product) {
    final state = this.state;
    final list = state.listProduct;
    emit(state.copyWith(
        listProduct: List<ProductModel>.from(list)..remove(product)));
  }

  void removeAll() {
    emit(state.copyWith(listProduct: []));
  }

  @override
  FavoriteState? fromJson(Map<String, dynamic> json) {
    return json["data"] == null
        ? const FavoriteState()
        : FavoriteState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(FavoriteState state) {
    return state.toJson();
  }
}
