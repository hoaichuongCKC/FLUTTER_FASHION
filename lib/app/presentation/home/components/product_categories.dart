import 'package:flutter_fashion/app/models/category/category.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';

const String urlAsset = "assets/images/test/";
const List<Map<String, dynamic>> listCategories = [
  {
    "imageUrl": "${urlAsset}cate_1.png",
    "label": "All",
  },
  {
    "imageUrl": "${urlAsset}cate_2.png",
    "label": "Men",
  },
  {
    "imageUrl": "${urlAsset}cate_3.png",
    "label": "Woman",
  },
  {
    "imageUrl": "${urlAsset}cate_4.png",
    "label": "Shoes",
  },
  {
    "imageUrl": "${urlAsset}cate_5.svg",
    "label": "Kid",
  },
];

class ProductCategoriesHome extends StatelessWidget {
  const ProductCategoriesHome({super.key, required this.categoryList});
  final List<CategoryModel> categoryList;
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: verticalPadding + 1),
      sliver: SliverToBoxAdapter(
        child: Column(
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
                  'Danh mục sản phẩm',
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
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: categoryList.length,
                itemExtent: 90,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: rangeColor[index],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                              ApiService.imageUrl + categoryList[index].photo,
                              headers: getIt<ApiService>().headers,
                              cacheKey: categoryList[index].photo,
                            ),
                          ),
                        ),
                        child: const SizedBox(
                          width: 60,
                          height: 60,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        categoryList[index].name,
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProductCategoryLoadingHome extends StatelessWidget {
  const ProductCategoryLoadingHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: verticalPadding + 1),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
              child: ColoredBox(
                color: skeletonColor,
                child: const SizedBox(width: 160, height: 10),
              ),
            ),
            const SizedBox(height: 8.0),
            SizedBox(
              height: 100,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 4,
                itemExtent: 90,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: skeletonColor,
                          shape: BoxShape.circle,
                        ),
                        child: const SizedBox(
                          height: 55,
                          width: 55,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      ColoredBox(
                        color: skeletonColor,
                        child: const SizedBox(width: 45, height: 10),
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
