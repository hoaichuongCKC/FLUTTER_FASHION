import 'package:flutter_fashion/app/models/product/product.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/utils/extensions/int.dart';

class PopularSearchHome extends StatelessWidget {
  const PopularSearchHome({super.key, required this.listProduct});
  final List<ProductModel> listProduct;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
            child: ListTile(
              dense: true,
              minVerticalPadding: 0,
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Sản phẩm phổ biến',
                style: PrimaryFont.instance.large(),
              ),
            ),
          ),
          SizedBox(
            height: 110,
            child: GridView.builder(
              itemCount: listProduct.length,
              shrinkWrap: true,
              padding:
                  const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 16 / 9,
                mainAxisExtent: 50.0,
              ),
              itemBuilder: (context, index) {
                final data = listProduct[index];
                return InkWell(
                  onTap: () {},
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: AspectRatio(
                          aspectRatio: 1.0,
                          child: CachedNetworkImage(
                            imageUrl: ApiService.imageUrl +
                                data.product_detail![0].photo,
                            fit: BoxFit.fill,
                            httpHeaders: getIt<ApiService>().headers,
                            placeholder: (context, url) {
                              return ColoredBox(
                                color: skeletonColor,
                                child: const SizedBox(),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                data.name!,
                                style: PrimaryFont.instance.small(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                            const SizedBox(height: 6.0),
                            Text(
                              '${data.view!.formatNumber()} lượt tìm kiếm',
                              style: PrimaryFont.instance.copyWith(
                                fontSize: 9.0,
                                height: 1.0,
                                fontWeight: FontWeight.w400,
                                color: const Color.fromARGB(255, 240, 157, 113),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PopularSearchSkeleton extends StatelessWidget {
  const PopularSearchSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
          child: ColoredBox(
            color: skeletonColor,
            child: const SizedBox(
              width: 60,
              height: 15.0,
            ),
          ),
        ),
        const SizedBox(height: 15.0),
        SizedBox(
          height: 110,
          child: GridView.builder(
            itemCount: 4,
            shrinkWrap: true,
            padding:
                const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 16 / 9,
              mainAxisExtent: 50.0,
            ),
            itemBuilder: (context, index) {
              return ColoredBox(color: skeletonColor);
            },
          ),
        ),
      ],
    );
  }
}
