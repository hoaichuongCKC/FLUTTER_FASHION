import 'package:flutter_fashion/app/presentation/product_detail/inherited.dart';

import '../../../../export.dart';

class DescDetail extends StatelessWidget {
  const DescDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductDetailInherited.of(context).productModel;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: verticalPadding + 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Mô tả",
            style: PrimaryFont.instance.copyWith(
              fontSize: 18.0,
            ),
          ),
          const SizedBox(height: 8.0),
          Text.rich(
            TextSpan(
              text: "- Xuất xứ:",
              children: [
                TextSpan(
                  text: " ${product.properties!.origin}",
                  style: PrimaryFont.instance.copyWith(
                    color: darkColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
              style: PrimaryFont.instance.copyWith(
                fontSize: 14.0,
                color: darkColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Text.rich(
            TextSpan(
              text: "- Chi tiết:",
              children: [
                TextSpan(
                  text: " ${product.desc}",
                  style: PrimaryFont.instance.copyWith(
                    color: darkColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
              style: PrimaryFont.instance.copyWith(
                fontSize: 14.0,
                color: darkColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
