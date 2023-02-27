import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fashion/app/presentation/login/export.dart';
import 'package:flutter_fashion/config/constant.dart';
import 'package:flutter_fashion/config/font_style.dart';
import 'package:flutter_fashion/core/base/api/api.dart';

class ProductRecommend extends StatelessWidget {
  const ProductRecommend({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product Recommend',
              style: PrimaryFont.instance.large(),
            ),
            const SizedBox(height: 8.0),
            GridView.builder(
              itemCount: 4,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 2 / 4,
                mainAxisExtent: 250.0,
              ),
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: AspectRatio(
                        aspectRatio: 4 / 3,
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://fashionminhthu.com.vn/wp-content/uploads/2018/11/short-sleeve-crew-neck-t-shirt-broadcast-print-1991-2-600x840.jpg',
                          fit: BoxFit.fitWidth,
                          httpHeaders: getIt<ApiService>().headers,
                          placeholder: (context, url) {
                            return const CircularProgressIndicator();
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nam Len Đen Áo Khoác Ngoài ...',
                            style: PrimaryFont.instance.copyWith(
                              fontSize: 14.0,
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '190.000 VNĐ',
                                style: PrimaryFont.instance.copyWith(
                                  fontSize: 14.0,
                                  color: const Color(0xFFFF7262),
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Sold: 1,2k',
                                    style: PrimaryFont.instance.copyWith(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  SvgPicture.asset(
                                    "assets/icons/shipping_delivery.svg",
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
