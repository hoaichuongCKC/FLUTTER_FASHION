// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'favorite_cubit.dart';

class FavoriteState extends Equatable {
  final List<ProductModel> listProduct;
  const FavoriteState({this.listProduct = const []});

  @override
  List<Object> get props => [listProduct];

  FavoriteState copyWith({
    List<ProductModel>? listProduct,
  }) {
    return FavoriteState(
      listProduct: listProduct ?? this.listProduct,
    );
  }

  FavoriteState.fromJson(Map<String, dynamic> json)
      : listProduct = (json['data'] as List)
            .map((itemJson) => ProductModel.fromJson(itemJson))
            .toList();

  Map<String, dynamic> toJson() => {
        'data': listProduct.map((item) => item.toJson()).toList(),
      };
}
