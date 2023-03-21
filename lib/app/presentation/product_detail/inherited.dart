import 'package:flutter_fashion/app/models/product/product.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/app/presentation/product_detail/blocs/ui_detail_bloc.dart';

class ProductDetailInherited extends InheritedWidget {
  final ProductModel productModel;
  final UiDetailShowBloc bloc;
  const ProductDetailInherited(
      {required this.productModel,
      required this.bloc,
      super.key,
      required super.child});

  static ProductDetailInherited of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ProductDetailInherited>()!;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}
