// ignore_for_file: invalid_override_of_non_virtual_member
import 'package:equatable/equatable.dart';
import 'package:flutter_fashion/app/blocs/user/user_cubit.dart';
import 'package:flutter_fashion/app/models/product/product.dart';
import 'package:flutter_fashion/app/presentation/login/export.dart';
import 'package:flutter_fashion/core/storage/key.dart';
import 'package:flutter_fashion/utils/alert/error.dart';
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

  void showCheckBox() {
    emit(state.copyWith(isShowCheckBox: !state.isShowCheckBox));
    _clearAllIndex();
  }

  void addId(int id) {
    final state = this.state;

    if (_checkExistIndex(id)) {
      return;
    }

    final updatedList = [id, ...state.chooseItemsDelete];

    emit(state.copyWith(chooseItemsDelete: updatedList));
  }

  void removeId(id) {
    final state = this.state;
    final updatedList = List<int>.from(state.chooseItemsDelete)..remove(id);

    emit(state.copyWith(chooseItemsDelete: updatedList));
  }

  void removeFavorite(ProductModel product) {
    final state = this.state;
    final list = state.listProduct;

    final updatedList = List<ProductModel>.from(list)
      ..retainWhere((item) => item.id != product.id);
    emit(state.copyWith(listProduct: updatedList));
  }

  void removeListFavorite(context) {
    final state = this.state;

    if (!_checkExistsList()) {
      errorAlert(context: context, message: "Vui lòng chọn sản phẩm");
      return;
    }

    final list = state.listProduct;

    for (int id in state.chooseItemsDelete) {
      final updatedList = List<ProductModel>.from(list)
        ..retainWhere(
          (item) => item.id != id,
        );

      emit(state.copyWith(listProduct: updatedList));
    }
    showCheckBox();
  }

  bool _checkExistsList() {
    final state = this.state;
    return state.chooseItemsDelete.isNotEmpty;
  }

  bool _checkExistIndex(int index) {
    final state = this.state;
    return state.chooseItemsDelete.contains(index);
  }

  void _clearAllIndex() {
    final state = this.state;
    if (state.chooseItemsDelete.isNotEmpty) {
      emit(state.copyWith(chooseItemsDelete: []));
    }
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
