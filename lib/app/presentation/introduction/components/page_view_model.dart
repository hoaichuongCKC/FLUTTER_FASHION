import 'package:flutter_fashion/app/config/font_style.dart';
import 'package:flutter_fashion/app/presentation/introduction/components/dot_page.dart';
import 'package:flutter_fashion/app/presentation/introduction/export.dart';

final dataIntro = [
  IntroViewModel(
    image: SvgPicture.asset(
      "assets/images/introduction/intro_1.svg",
      fit: BoxFit.cover,
    ),
    title: 'Chào mừng bạn',
    subtitle: 'đến với chúng tôi!!',
  ),
  IntroViewModel(
    image: SvgPicture.asset(
      "assets/images/introduction/intro_2.svg",
      fit: BoxFit.cover,
    ),
    title: 'Sản phẩm đa dạng',
    subtitle: 'mua sắm thả ga',
  ),
  IntroViewModel(
    image: SvgPicture.asset(
      "assets/images/introduction/intro_3.svg",
      fit: BoxFit.contain,
    ),
    title: 'Thanh toán & giao hàng',
    subtitle: 'nhanh chóng tiện lợi',
  ),
];

class PageViewModel extends StatefulWidget {
  const PageViewModel({
    super.key,
  });

  @override
  State<PageViewModel> createState() => _PageViewModelState();
}

class _PageViewModelState extends State<PageViewModel> {
  int currentPage = 0;

  late PageController _pageController;

  bool isIntroLast = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentPage)
      ..addListener(
        () {
          final double pageControl = _pageController.page!;

          final lastIndex = dataIntro.length - 1;

          isIntroLast = pageControl.round() == lastIndex;

          currentPage = pageControl.round();

          setState(() {});
        },
      );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _pageController.removeListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(flex: 2),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 2,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: dataIntro.length,
                    itemBuilder: (ctx, index) {
                      return dataIntro[index].image;
                    },
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: FractionallySizedBox(
                          heightFactor: 0.5,
                          widthFactor: 0.8,
                          child: FittedBox(
                            child: Text(
                              dataIntro[currentPage].title,
                              textAlign: TextAlign.center,
                              style: PrimaryFont.instance.copyWith(
                                fontWeight: FontWeight.w300,
                                fontSize: 12.0,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: FractionallySizedBox(
                          heightFactor: 0.5,
                          widthFactor: 0.8,
                          alignment: Alignment.topCenter,
                          child: FittedBox(
                            child: Text(
                              dataIntro[currentPage].subtitle,
                              textAlign: TextAlign.center,
                              style: PrimaryFont.instance.copyWith(
                                fontWeight: FontWeight.w300,
                                fontSize: 12.0,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FractionallySizedBox(
              widthFactor: 0.9,
              heightFactor: 0.5,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 1,
                    child: isIntroLast
                        ? const TextButton(onPressed: null, child: SizedBox())
                        : TextButton(
                            onPressed: () {
                              _pageController.animateToPage(
                                  currentPage + dataIntro.length - 1,
                                  duration: const Duration(milliseconds: 450),
                                  curve: Curves.easeIn);
                            },
                            child: const Text('Bỏ qua'),
                          ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Align(
                      child: DotPage(
                        currentDot: currentPage,
                        length: dataIntro.length,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: () {
                        if (!(currentPage == dataIntro.length - 1)) {
                          _pageController.animateToPage(currentPage + 1,
                              duration: const Duration(milliseconds: 450),
                              curve: Curves.easeIn);
                        } else {
                          AppRoutes.go(Routes.LOGIN);
                        }
                      },
                      child: (currentPage == dataIntro.length - 1)
                          ? const Text('Xong')
                          : const Text('Tiếp tục'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
