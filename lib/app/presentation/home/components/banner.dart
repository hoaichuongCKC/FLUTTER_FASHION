import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fashion/common/components/dot_page.dart';
import 'package:flutter_fashion/config/constant.dart';

class BannerHome extends StatefulWidget {
  const BannerHome({super.key});

  @override
  State<BannerHome> createState() => _BannerHomeState();
}

class _BannerHomeState extends State<BannerHome> {
  final List<String> _bannerList = [
    "assets/images/test/banner_1.png",
    "assets/images/test/banner_2.jpg",
    "assets/images/test/banner_3.jpg",
  ];

  int _currentPage = 0;

  late final PageController _pageController =
      PageController(initialPage: _currentPage);

  late Timer _timer;

  Duration slideDuration = const Duration(milliseconds: 500);
  Duration slideIntervel = const Duration(seconds: 5);

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_listenChangePage);
    _timer = Timer.periodic(slideIntervel, _handleAutoSlide);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.removeListener(_listenChangePage);
    _timer.cancel();
  }

  void _handleAutoSlide(timer) {
    if (_currentPage == _bannerList.length - 1) {
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
                itemCount: _bannerList.length,
                itemBuilder: (ctx, index) {
                  return AnimatedOpacity(
                    opacity: _currentPage == index ? 1.0 : 0.3,
                    duration: slideDuration,
                    child: Image.asset(
                      _bannerList[index],
                      fit: BoxFit.fill,
                      key: ValueKey("$index"),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8.0),
            DotPage(length: _bannerList.length, currentDot: _currentPage),
          ],
        ),
      ),
    );
  }
}
