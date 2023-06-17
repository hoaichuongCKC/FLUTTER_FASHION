// ignore_for_file: invalid_override_of_non_virtual_member
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_fashion/app/blocs/user/user_cubit.dart';
import 'package:flutter_fashion/app/models/product/product.dart';
import 'package:flutter_fashion/app/presentation/login/export.dart';
import 'package:flutter_fashion/core/storage/key.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    final updatedIdList = [...state.idList, product.id]..sort();
    emit(state.copyWith(listProduct: updatedList, idList: updatedIdList));
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

    final idList = state.idList;

    final updatedList = List<ProductModel>.from(list)
      ..retainWhere((item) => item.id != product.id);

    final updatedIdList = List<int?>.from(idList)
      ..retainWhere((item) => item != product.id);

    emit(state.copyWith(listProduct: updatedList, idList: updatedIdList));
  }

  void removeListFavorite() {
    if (!_checkExistsList()) {
      showErrorToast("Vui lòng chọn sản phẩm", toastLength: Toast.LENGTH_SHORT);
      return;
    }

    if (state.chooseItemsDelete.length == state.listProduct.length) {
      emit(state.copyWith(listProduct: [], idList: [], chooseItemsDelete: []));
      showCheckBox();
      return;
    }

    late List<ProductModel> updatedList;

    late List<int> updatedListId;

    final list = state.listProduct;

    for (int id in state.chooseItemsDelete) {
      updatedList = List<ProductModel>.from(list)
        ..removeWhere(
          (item) => item.id == id,
        );

      updatedListId = List<int>.from(state.idList)
        ..removeWhere(
          (item) => item == id,
        );
    }
    emit(state.copyWith(
        listProduct: updatedList,
        idList: updatedListId,
        chooseItemsDelete: []));

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
    emit(state.copyWith(listProduct: [], idList: []));
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
