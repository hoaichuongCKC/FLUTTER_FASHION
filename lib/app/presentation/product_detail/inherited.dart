import 'package:flutter_fashion/app/models/product/product.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';

class ProductDetailInherited extends InheritedWidget {
  final ProductModel productModel;
  const ProductDetailInherited(
      {required this.productModel, super.key, required super.child});

  static ProductDetailInherited of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ProductDetailInherited>()!;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}
