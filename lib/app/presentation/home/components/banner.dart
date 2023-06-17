import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:carousel_slider/carousel_slider.dart';

class BannerHome extends StatelessWidget {
  const BannerHome({
    super.key,
    this.bannerList = const [],
  });

  final List<SliderModel> bannerList;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(bottom: 32, top: 16),
        child: CarouselSlider(
            items: bannerList.map((e) {
              return ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(radiusBtn),
                ),
                child: CachedNetworkImage(
                  imageUrl: ApiService.imageUrl + e.photo,
                  fit: BoxFit.fill,
                  key: ValueKey(ApiService.imageUrl + e.photo),
                  httpHeaders: getIt<ApiService>().headers,
                ),
              );
            }).toList(),
            options: CarouselOptions(
              height: 180,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 6),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              // onPageChanged: callbackFunction,
              scrollDirection: Axis.horizontal,
            )),
      ),
    );
  }

  // Widget _buildBody() {
  //   return SliverPadding(
  //     padding: const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
  //     sliver: SliverToBoxAdapter(
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           const SizedBox(height: 20),
  //           SizedBox(
  //             width: double.maxFinite,
  //             height: 180.0,
  //             child: PageView.builder(
  //               controller: _pageController,
  //               itemCount: widget.bannerList.length,
  //               itemBuilder: (ctx, index) {
  //                 return AnimatedOpacity(
  //                   opacity: _currentPage == index ? 1.0 : 0.3,
  //                   duration: slideDuration,
  //                   child:
  //                 );
  //               },
  //             ),
  //           ),
  //           const SizedBox(height: 8.0),
  //           DotPage(
  //             length: widget.bannerList.length,
  //             currentDot: _currentPage,
  //             disableDot: !ThemeDataApp.instance.isLight
  //                 ? Theme.of(context).indicatorColor
  //                 : darkColor,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  //}
}

class BannerSkeletonHome extends StatelessWidget {
  const BannerSkeletonHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ColoredBox(
              color: skeletonColor,
              child: const SizedBox(
                width: double.maxFinite,
                height: 165.0,
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 3; ++i)
                  Padding(
                    padding: EdgeInsets.only(right: i == 2 ? 0 : 5.0),
                    child: ColoredBox(
                      color: skeletonColor,
                      child: const SizedBox(width: 15, height: 15),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BannerErrorHome extends StatelessWidget {
  const BannerErrorHome({super.key, required this.error});
  final String error;
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              error,
              style: PrimaryFont.instance.copyWith(
                fontSize: 16.0,
                color: errorColor,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 8.0),
            ButtonWidget(
              width: 100.0,
              onPressed: () => context.read<BannerCubit>().fetchData(context),
              child: Text(
                "Try reload",
                style: PrimaryFont.instance.copyWith(
                  fontSize: 14.0,
                  color: lightColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
