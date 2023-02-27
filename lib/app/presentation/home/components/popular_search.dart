import 'package:flutter/material.dart';
import 'package:flutter_fashion/config/colors.dart';
import 'package:flutter_fashion/config/constant.dart';
import 'package:flutter_fashion/config/font_style.dart';

const List _rangeColor = [
  disablePrimaryColor,
  Color(0xFFFFCCCC),
  Color(0xFFEDEBA8),
  Color(0xFFE2CDEC),
];

class PopularSearchHome extends StatelessWidget {
  const PopularSearchHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
            child: Text(
              'Popular Search',
              style: PrimaryFont.instance.large(),
            ),
          ),
          const SizedBox(height: 8.0),
          SizedBox(
            height: 110,
            child: GridView.builder(
              itemCount: 4,
              shrinkWrap: true,
              padding:
                  const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 16 / 9,
                mainAxisExtent: 50.0,
              ),
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: _rangeColor[index],
                      ),
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: Image.asset("assets/images/test/shoes.png"),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Giày Nike',
                              style: PrimaryFont.instance.small()),
                          const SizedBox(height: 6.0),
                          Text(
                            '200 numbers of searches',
                            style: PrimaryFont.instance.copyWith(
                              fontSize: 9.0,
                              height: 1.0,
                              fontWeight: FontWeight.w300,
                              color: const Color(0xFFFFBF9D),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
