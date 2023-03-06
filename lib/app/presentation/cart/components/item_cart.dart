import 'package:flutter_fashion/app/presentation/cart/components/counter_cart.dart';
import '../../../../export.dart';

class ItemCart extends StatefulWidget {
  const ItemCart({super.key, required this.index});
  final int index;

  @override
  State<ItemCart> createState() => _ItemCartState();
}

class _ItemCartState extends State<ItemCart> {
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, 0),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: lightColor,
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
          boxShadow: [
            BoxShadow(
              color: disablePrimaryColor,
              blurRadius: 8.0,
            )
          ],
        ),
        child: SizedBox(
          height: 120.0,
          child: Padding(
            padding: const EdgeInsets.all(horizontalPadding / 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 1.0,
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://fashionminhthu.com.vn/wp-content/uploads/2018/11/short-sleeve-crew-neck-t-shirt-broadcast-print-1991-2-600x840.jpg',
                            fit: BoxFit.fitWidth,
                            placeholder: (context, url) {
                              return ColoredBox(
                                color: skeletonColor,
                                child: const SizedBox(),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Nam Len Đen Áo Khoác Ngoài da nữ xinh việt nam sssssssss',
                                      style: PrimaryFont.instance.copyWith(
                                        fontSize: 14.0,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.clear,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '190.000 VNĐ',
                                  style: PrimaryFont.instance.copyWith(
                                    fontSize: 12.0,
                                    color: const Color(0xFFFF7262),
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                const CounterCart(),
                              ],
                            ),
                            ColoredBox(
                              color: errorColor.withOpacity(0.2),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 1.0),
                                child: Text(
                                  '-10.000VNĐ',
                                  style: PrimaryFont.instance.copyWith(
                                    fontSize: 7.0,
                                    color: errorColor,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Phân loại: ",
                        style: PrimaryFont.instance.copyWith(
                          fontSize: 14.0,
                          color: disableDarkColor,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const WidgetSpan(child: SizedBox(width: 5.0)),
                      TextSpan(
                        text: "S (40-58kg),",
                        style: PrimaryFont.instance.copyWith(
                          fontSize: 14.0,
                          color: disableDarkColor,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const WidgetSpan(child: SizedBox(width: 5.0)),
                      WidgetSpan(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: primaryColor,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: primaryColor,
                            ),
                          ),
                          child: const SizedBox(
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                      const WidgetSpan(child: SizedBox(width: 5.0)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
