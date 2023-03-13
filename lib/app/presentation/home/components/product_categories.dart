import 'package:flutter_fashion/app/models/category/category.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';

class ProductCategoriesHome extends StatelessWidget {
  const ProductCategoriesHome({super.key, required this.categoryList});
  final List<CategoryModel> categoryList;
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 0),
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
                  'Danh mục',
                  style: PrimaryFont.instance.large(),
                ),
                trailing: InkWell(
                  onTap: () => AppRoutes.router.pushNamed(
                    Names.CATEGORY,
                    queryParams: {
                      "search_key": "",
                      "item": categoryList[0].id.toString()
                    },
                  ),
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
                  return InkWell(
                    onTap: () => AppRoutes.router.pushNamed(
                      Names.CATEGORY,
                      queryParams: {
                        "search_key": "",
                        "item": categoryList[index].id.toString()
                      },
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: rangeColor[index],
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.contain,
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
                          categoryList[index].name_vi,
                          style: PrimaryFont.instance.copyWith(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
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
