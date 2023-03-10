import 'package:flutter_fashion/app/models/product/product.dart';
import 'package:flutter_fashion/app/presentation/home/blocs/loadmore_bloc.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/common/components/item_product.dart';

class ProductRecommend extends StatelessWidget {
  const ProductRecommend(
      {super.key,
      required this.listProduct,
      required this.loadMoreProductbloc});
  final List<ProductModel> listProduct;
  final LoadMoreProductBloc loadMoreProductbloc;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              dense: true,
              minVerticalPadding: 0,
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Gợi ý sản phẩm',
                style: PrimaryFont.instance.large(),
              ),
              trailing: InkWell(
                onTap: () {},
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Xem tất cả',
                      style: PrimaryFont.instance.copyWith(
                        fontSize: 12.0,
                        color: primaryColor,
                      ),
                    ),
                    const Icon(Icons.arrow_right,
                        size: 25.0, color: primaryColor),
                  ],
                ),
              ),
            ),
            GridView.builder(
              itemCount: listProduct.length,
              // controller: _scrollController,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 2 / 4,
                mainAxisExtent: 255.0,
              ),
              itemBuilder: (context, index) {
                return ItemProduct(product: listProduct[index]);
              },
            ),
            StreamBuilder(
              stream: loadMoreProductbloc.getProductStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox();
                }
                if (snapshot.connectionState == ConnectionState.active &&
                    snapshot.hasData &&
                    snapshot.data!.isNotEmpty) {
                  return GridView.builder(
                    itemCount: snapshot.data!.length,
                    // controller: _scrollController,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 2 / 4,
                      mainAxisExtent: 255.0,
                    ),
                    itemBuilder: (context, index) {
                      return ItemProduct(product: snapshot.data![index]);
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
