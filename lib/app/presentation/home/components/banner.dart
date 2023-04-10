import 'package:flutter_fashion/app/presentation/home/export.dart';

class BannerHome extends StatefulWidget {
  const BannerHome({
    super.key,
    this.bannerList = const [],
  });

  final List<SliderModel> bannerList;

  @override
  State<BannerHome> createState() => _BannerHomeState();
}

class _BannerHomeState extends State<BannerHome> {
  int _currentPage = 0;

  late PageController _pageController;

  late Timer _timer;

  Duration slideDuration = const Duration(milliseconds: 500);
  Duration slideIntervel = const Duration(seconds: 5);

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: _currentPage);
    _pageController.addListener(_listenChangePage);
    _timer = Timer.periodic(slideIntervel, _handleAutoSlide);
  }

  @override
  void dispose() {
    _pageController.removeListener(_listenChangePage);
    _timer.cancel();
    super.dispose();
  }

  void _handleAutoSlide(timer) {
    if (_currentPage == widget.bannerList.length - 1) {
      _currentPage = 0;
      _pageController.jumpToPage(0);
    } else {
      _currentPage++;
      _pageController.animateToPage(
        _currentPage,
        duration: slideDuration,
        curve: Curves.easeIn,
      );
    }
    setState(() {});
  }

  void _listenChangePage() {
    _currentPage = _pageController.page!.round();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.maxFinite,
              height: 165.0,
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.bannerList.length,
                itemBuilder: (ctx, index) {
                  return AnimatedOpacity(
                    opacity: _currentPage == index ? 1.0 : 0.3,
                    duration: slideDuration,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(radiusBtn),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: ApiService.imageUrl +
                            widget.bannerList[index].photo,
                        fit: BoxFit.fill,
                        key: ValueKey(ApiService.imageUrl +
                            widget.bannerList[index].photo),
                        httpHeaders: getIt<ApiService>().headers,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8.0),
            DotPage(length: widget.bannerList.length, currentDot: _currentPage),
          ],
        ),
      ),
    );
  }
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
              height: 40.0,
              width: 100.0,
              onPressed: () => context.read<BannerCubit>().fetchData(context),
              btnColor: primaryColor,
              labelWidget: Text(
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
