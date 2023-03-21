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
          Text(
            "- Xuất xứ: ${product.properties.origin!}",
            style: PrimaryFont.instance.copyWith(
              fontSize: 14.0,
              color: disableDarkColor.withOpacity(0.5),
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            "- Chi tiết: ${product.desc}",
            style: PrimaryFont.instance.copyWith(
              fontSize: 14.0,
              color: disableDarkColor.withOpacity(0.5),
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
