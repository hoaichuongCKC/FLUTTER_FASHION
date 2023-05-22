// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'favorite_cubit.dart';

class FavoriteState extends Equatable {
  final List<ProductModel> listProduct;

  final List<int?> idList;

  final List<int> chooseItemsDelete;

  final bool isShowCheckBox;

  const FavoriteState({
    this.listProduct = const [],
    this.idList = const [],
    this.chooseItemsDelete = const [],
    this.isShowCheckBox = false,
  });

  @override
  List<Object> get props =>
      [listProduct, chooseItemsDelete, isShowCheckBox, idList];

  FavoriteState copyWith({
    List<ProductModel>? listProduct,
    List<int>? chooseItemsDelete,
    bool? isShowCheckBox,
    List<int?>? idList,
  }) {
    return FavoriteState(
      listProduct: listProduct ?? this.listProduct,
      chooseItemsDelete: chooseItemsDelete ?? this.chooseItemsDelete,
      isShowCheckBox: isShowCheckBox ?? this.isShowCheckBox,
      idList: idList ?? this.idList,
    );
  }

  factory FavoriteState.fromJson(Map<String, dynamic> json) {
    final data = (json['data'] as List)
        .map((itemJson) => ProductModel.fromJson(itemJson))
        .toList();

    List<dynamic> idList = jsonDecode(json['idList']);

    if (idList.isEmpty) {
      return const FavoriteState();
    }

    late List<int> newList;

    newList = idList.map<int>((itemJson) => int.parse("$itemJson")).toList();

    return FavoriteState(
      listProduct: data,
      idList: newList,
    );
  }

  Map<String, dynamic> toJson() => {
        'data': listProduct.map((item) => item.toJson()).toList(),
        'idList': jsonEncode(idList)
      };
}
