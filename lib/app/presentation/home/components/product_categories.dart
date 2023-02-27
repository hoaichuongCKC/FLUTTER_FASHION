import 'package:flutter/material.dart';
import 'package:flutter_fashion/config/constant.dart';
import 'package:flutter_fashion/config/font_style.dart';
import 'package:flutter_svg/svg.dart';

const String urlAsset = "assets/images/test/";
const List<Map<String, dynamic>> listCategories = [
  {
    "imageUrl": "${urlAsset}cate_1.png",
    "label": "All",
  },
  {
    "imageUrl": "${urlAsset}cate_2.png",
    "label": "Men",
  },
  {
    "imageUrl": "${urlAsset}cate_3.png",
    "label": "Woman",
  },
  {
    "imageUrl": "${urlAsset}cate_4.png",
    "label": "Shoes",
  },
  {
    "imageUrl": "${urlAsset}cate_5.svg",
    "label": "Kid",
  },
];

class ProductCategoriesHome extends StatelessWidget {
  const ProductCategoriesHome({super.key});

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
              child: Text(
                'Product Categories',
                style: PrimaryFont.instance.large(),
              ),
            ),
            const SizedBox(height: 8.0),
            SizedBox(
              height: 100,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: listCategories.length,
                itemExtent: 90,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      index != listCategories.length - 1
                          ? Image.asset(listCategories[index]["imageUrl"])
                          : SvgPicture.asset(listCategories[index]["imageUrl"]),
                      const SizedBox(height: 8.0),
                      Text(listCategories[index]["label"]),
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
