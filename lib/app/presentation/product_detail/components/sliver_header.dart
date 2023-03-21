import 'package:flutter_fashion/app/presentation/product_detail/inherited.dart';
import 'package:flutter_fashion/core/base/api/api.dart';
import '../../../../export.dart';

const _maxExpandedHeight = 300.0;

class SliverHeaderProduct extends StatelessWidget {
  const SliverHeaderProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final detailInherited = ProductDetailInherited.of(context);

    return SliverAppBar(
      elevation: 5.0,
      scrolledUnderElevation: 5.0,
      excludeHeaderSemantics: true,
      backgroundColor: lightColor,
      automaticallyImplyLeading: false,
      leadingWidth: 50.0,
      leading: InkWell(
        onTap: () => AppRoutes.router.pop(),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: disableDarkColor.withOpacity(0.5),
            ),
            child: const Center(
              child: Icon(
                Icons.arrow_back,
                size: 24.0,
                color: lightColor,
              ),
            ),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: SvgPicture.asset("assets/icons/favorite.svg"),
        ),
      ],
      pinned: false,
      stretch: true,
      expandedHeight: _maxExpandedHeight,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.zero,
        stretchModes: const [StretchMode.zoomBackground, StretchMode.fadeTitle],
        background: StreamBuilder<int>(
          stream: detailInherited.bloc.imageStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox();
            }
            if (!snapshot.hasData) {
              return const SizedBox();
            }
            final id = snapshot.data!;
            return AspectRatio(
              aspectRatio: 16 / 12,
              child: CachedNetworkImage(
                key: ValueKey(
                    detailInherited.productModel.product_detail[id].photo),
                imageUrl: ApiService.imageUrl +
                    detailInherited.productModel.product_detail[id].photo,
                fit: BoxFit.cover,
                cacheKey: detailInherited.productModel.product_detail[id].photo,
              ),
            );
          },
        ),
      ),
    );
  }
}

class SliverSubImage extends StatelessWidget {
  const SliverSubImage({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductDetailInherited.of(context).productModel;
    final bloc = ProductDetailInherited.of(context).bloc;
    if (product.product_detail.length == 1) {
      return const SliverToBoxAdapter();
    }
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: verticalPadding + 1),
      sliver: SliverToBoxAdapter(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: product.product_detail.map(
            (item) {
              final index = product.product_detail.indexOf(item);
              return Padding(
                padding: EdgeInsets.only(
                    right:
                        index == product.product_detail.length - 1 ? 0 : 8.0),
                child: InkWell(
                  onTap: () => bloc.selectImage(index),
                  child: StreamBuilder<int>(
                    stream: bloc.imageStream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox();
                      }
                      if (!snapshot.hasData) {
                        return const SizedBox();
                      }
                      final id = snapshot.data!;
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: id == index
                              ? Border.all(
                                  color: primaryColor,
                                )
                              : null,
                        ),
                        child: AnimatedScale(
                          scale: id == index ? 0.8 : 1.0,
                          curve: Curves.fastLinearToSlowEaseIn,
                          duration: const Duration(milliseconds: 350),
                          child: SizedBox(
                            width: 45.0,
                            height: 50,
                            child: CachedNetworkImage(
                              key: ValueKey(item.photo),
                              imageUrl: ApiService.imageUrl + item.photo,
                              fit: BoxFit.cover,
                              cacheKey: item.photo,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
