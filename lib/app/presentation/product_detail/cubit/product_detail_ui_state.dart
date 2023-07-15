// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'product_detail_ui_cubit.dart';

class ProductDetailUiState extends Equatable {
  //handle when choose photo
  final int productDetailID;

  final int indexImage;
  //end

  final String color;

  final String size;

  final int quantity;

  //handle button view to up
  final bool isShow;
  //end

  final bool hasLoadMore;

  const ProductDetailUiState({
    this.productDetailID = 0,
    this.indexImage = 0,
    this.color = "",
    this.size = "",
    this.quantity = 1,
    this.isShow = false,
    this.hasLoadMore = true,
  });

  @override
  List<Object> get props =>
      [indexImage, color, size, quantity, isShow, hasLoadMore, productDetailID];

  ProductDetailUiState copyWith({
    int? productDetailID,
    int? indexImage,
    String? color,
    String? size,
    int? quantity,
    bool? isShow,
    bool? hasLoadMore,
  }) {
    return ProductDetailUiState(
      productDetailID: productDetailID ?? this.productDetailID,
      indexImage: indexImage ?? this.indexImage,
      color: color ?? this.color,
      size: size ?? this.size,
      quantity: quantity ?? this.quantity,
      isShow: isShow ?? this.isShow,
      hasLoadMore: hasLoadMore ?? this.hasLoadMore,
    );
  }
}
