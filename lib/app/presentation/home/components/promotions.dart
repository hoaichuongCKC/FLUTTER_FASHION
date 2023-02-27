import 'package:flutter_fashion/app/presentation/login/export.dart';
import 'package:flutter_fashion/config/constant.dart';

import '../../../../export.dart';

class ListPromotion extends StatelessWidget {
  const ListPromotion({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: verticalPadding + 1),
      sliver: SliverToBoxAdapter(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
              child: Text(
                'Promotions',
                style: PrimaryFont.instance.large(),
              ),
            ),
            const SizedBox(height: 8.0),
            SizedBox(
              height: 140.0,
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(width: 15.0),
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                    horizontal: horizontalPadding - 4),
                cacheExtent: 140.0,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width * .7,
                    child: Stack(
                      children: [
                        SvgPicture.asset(
                          "assets/images/promotion_card.svg",
                          fit: BoxFit.cover,
                          placeholderBuilder: (context) =>
                              const CircularProgressIndicator(),
                        ),
                        Positioned(
                          top: 8.0,
                          left: 8.0,
                          right: 8.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Discount',
                                        style: PrimaryFont.instance.copyWith(
                                          color: lightColor,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      Text(
                                        '10.000 VNĐ',
                                        style: PrimaryFont.instance.copyWith(
                                          color: lightColor,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  ButtonWidget(
                                    btnColor: lightColor,
                                    height: 35.0,
                                    width: 70,
                                    radius: 3.0,
                                    onPressed: () {},
                                    labelWidget: Text(
                                      "View",
                                      style: PrimaryFont.instance.copyWith(
                                        fontSize: 12,
                                        color: primaryColor,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 140 / 2 + 10,
                          left: 8.0,
                          right: 8.0,
                          bottom: 8.0,
                          child: Column(
                            children: [
                              Text(
                                'To use this voucher, the order must be at least 60k in value.',
                                style: PrimaryFont.instance.copyWith(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w300,
                                  color: lightColor,
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      "assets/icons/stopwatch-minus.svg"),
                                  Text(
                                    'Expiring: 1 day left',
                                    style: PrimaryFont.instance.copyWith(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w300,
                                      color: lightColor,
                                    ),
                                  ),
                                ],
                              )
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
      ),
    );
  }
}
