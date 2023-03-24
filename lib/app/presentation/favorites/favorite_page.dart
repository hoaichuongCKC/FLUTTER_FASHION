import 'package:flutter_fashion/app/blocs/favorite/favorite_cubit.dart';
import 'package:flutter_fashion/export.dart';
import '../../../common/components/app/background_app.dart';
import '../../../common/components/item_product.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackgroundBlur.normal(
      title: "Yêu thích",
      isHasBackground: false,
      child: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          final listProduct = state.listProduct;
          if (listProduct.isEmpty) {
            return const Center(
              child: Text("Hiện bạn chưa có sản phẩm nào"),
            );
          }
          return GridView.builder(
            itemCount: listProduct.length,
            shrinkWrap: true,
            padding:
                const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 2 / 4,
              mainAxisExtent: 230.0,
            ),
            itemBuilder: (context, index) {
              return ItemProduct(
                onTap: () {},
                product: listProduct[index],
              );
            },
          );
        },
      ),
    );
  }
}
