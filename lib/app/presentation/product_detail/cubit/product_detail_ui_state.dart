// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'product_detail_ui_cubit.dart';

class ProductDetailUiState extends Equatable {
  final int indexImage;
  final String color;
  final String size;
  final int quantity;

  const ProductDetailUiState({
    this.indexImage = 0,
    this.color = "",
    this.size = "",
    this.quantity = 1,
  });

  @override
  List<Object> get props => [indexImage, color, size, quantity];

  ProductDetailUiState copyWith({
    int? indexImage,
    String? color,
    String? size,
    int? quantity,
  }) {
    return ProductDetailUiState(
      indexImage: indexImage ?? this.indexImage,
      color: color ?? this.color,
      size: size ?? this.size,
      quantity: quantity ?? this.quantity,
    );
  }
}
