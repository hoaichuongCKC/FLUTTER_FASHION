import 'package:flutter_fashion/app/models/product/product.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/common/components/item_product.dart';

class ProductRecommend extends StatefulWidget {
  const ProductRecommend({super.key, required this.listProduct});
  final List<ProductModel> listProduct;
  @override
  State<ProductRecommend> createState() => _ProductRecommendState();
}

class _ProductRecommendState extends State<ProductRecommend> {
  late ScrollController _scrollController;
  final GlobalKey keyAreaProduct = GlobalKey();
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_loadMore);
  }

  void _loadMore() {
    final renderbox =
        keyAreaProduct.currentContext!.findRenderObject() as RenderBox;
    final offset = renderbox.localToGlobal(Offset.zero);
    print(offset.dy);
    // _productCubit.loadMoreProducts(_scrollController);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollController.removeListener(_loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product Recommend',
              style: PrimaryFont.instance.large(),
            ),
            const SizedBox(height: 8.0),
            GridView.builder(
              itemCount: widget.listProduct.length,
              controller: _scrollController,
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
                return ItemProduct(product: widget.listProduct[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}
