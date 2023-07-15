import 'package:flutter_fashion/app/models/category/category.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/common/widgets/new_widget.dart';
import 'package:flutter_fashion/utils/extensions/datetime.dart';

class ProductCategoriesHome extends StatelessWidget {
  const ProductCategoriesHome({super.key, required this.categoryList});

  final List<CategoryModel> categoryList;

  @override
  Widget build(BuildContext context) {
    final isVietnamese = context.watch<SettingsCubit>().state.isVietnamese;

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
                  AppLocalizations.of(context)!.categories,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
            ),
            ConstrainedBoxWidget(
              currentHeight: 0.2,
              maxHeight: 250.0,
              minHeight: 180.0,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      mainAxisExtent: constraints.biggest.height / 2,
                    ),
                    padding: EdgeInsets.zero,
                    itemCount: categoryList.length + 1,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      if (index == categoryList.length) {
                        return InkWell(
                          onTap: () {
                            AppRoutes.router.pushNamed(
                              Names.CATEGORY,
                              queryParams: {
                                "index": "0",
                              },
                            );
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              DecoratedBox(
                                decoration: const BoxDecoration(
                                  color: lightColor,
                                  shape: BoxShape.circle,
                                ),
                                child: SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: SvgPicture.asset(
                                    "assets/icons/all.svg",
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                AppLocalizations.of(context)!.view_all,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontSize: 12.0),
                              ),
                            ],
                          ),
                        );
                      }
                      final item = categoryList[index];
                      final subtitle = isVietnamese ? item.name_vi : item.name;

                      return InkWell(
                        onTap: () {
                          context.read<CategoryTabCubit>().changeTab(item.id);
                          AppRoutes.router.pushNamed(
                            Names.CATEGORY,
                            queryParams: {
                              "index": "${index + 1}",
                            },
                          );
                        },
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: lightColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: textDisable.withOpacity(0.3),
                                        width: 0.5),
                                    image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: CachedNetworkImageProvider(
                                        ApiService.imageUrl +
                                            categoryList[index].photo,
                                        headers:
                                            getIt.get<ApiService>().headers,
                                        cacheKey: categoryList[index].photo,
                                      ),
                                    ),
                                  ),
                                  child: const SizedBox(
                                    width: 60,
                                    height: 60,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  subtitle,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontSize: 12.0),
                                ),
                              ],
                            ),
                            !item.created_at!.checkNewProduct
                                ? const SizedBox()
                                : const Positioned(
                                    top: 0,
                                    right: 5,
                                    child: NewWidget(),
                                  ),
                          ],
                        ),
                      );
                    },
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
            ConstrainedBoxWidget(
              currentHeight: 0.2,
              maxHeight: 250.0,
              minHeight: 180.0,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      mainAxisExtent: constraints.biggest.height / 2,
                    ),
                    padding: EdgeInsets.zero,
                    itemCount: 6,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: skeletonColor,
                        ),
                      );
                    },
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
