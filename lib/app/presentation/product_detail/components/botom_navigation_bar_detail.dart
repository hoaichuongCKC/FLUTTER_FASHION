import 'package:flutter_fashion/app/models/product/product.dart';
import 'package:flutter_fashion/app/presentation/cart/components/counter_cart.dart';
import 'package:flutter_fashion/app/presentation/product_detail/blocs/ui_detail_bloc.dart';
import 'package:flutter_fashion/app/presentation/product_detail/inherited.dart';
import 'package:flutter_fashion/export.dart';

class BottomNavigationbarDetail extends StatelessWidget {
  const BottomNavigationbarDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final inheritedDetail = ProductDetailInherited.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: lightColor,
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: ConstrainedBoxWidget(
          currentHeight: 0.1,
          maxHeight: 45.0,
          minHeight: 40.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                flex: 1,
                child: FractionallySizedBox(
                  heightFactor: 1.0,
                  child: ButtonWidget(
                    height: 40.0,
                    animate: true,
                    radius: 5.0,
                    btnColor: primaryColor,
                    onPressed: () => showModalOption(context,
                        inheritedDetail.productModel, inheritedDetail.bloc),
                    label: "Đặt hàng",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showModalOption(
    BuildContext context, ProductModel product, UiDetailShowBloc bloc) {
  showModalBottomSheet(
    backgroundColor: lightColor,
    isScrollControlled: true,
    useSafeArea: true,
    elevation: 5.0,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(5.0),
        topRight: Radius.circular(5.0),
      ),
    ),
    builder: (context) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * .65,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: horizontalPadding - 4, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                child: Text(
                  'Lựa chọn',
                  style: PrimaryFont.instance.copyWith(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Divider(color: darkColor.withOpacity(0.4)),
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: Text(
                  'Số lượng:',
                  style: PrimaryFont.instance.copyWith(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                title: CounterCart(
                  iconSize: 24.0,
                  onChanged: (p0) => bloc.counter(p0),
                ),
              ),
              product.properties!.colors!.isEmpty
                  ? const SizedBox()
                  : ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      leading: Text(
                        'Màu sắc:',
                        style: PrimaryFont.instance.copyWith(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      title: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: product.properties!.colors!
                            .map(
                              (e) => StreamBuilder<String>(
                                stream: bloc.colorStream,
                                builder: (context, snapshot) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: snapshot.data != e
                                            ? null
                                            : Border.all(color: primaryColor),
                                      ),
                                      child: Padding(
                                        padding: snapshot.data != e
                                            ? EdgeInsets.zero
                                            : const EdgeInsets.all(3.0),
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(
                                              int.parse("0xFF$e"),
                                            ),
                                          ),
                                          child: InkWell(
                                            onTap: () => bloc.selectColor(e),
                                            child: const SizedBox(
                                              width: 25.0,
                                              height: 25.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                            .toList(),
                      ),
                    ),
              product.properties!.sizes!.isEmpty
                  ? const SizedBox()
                  : ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      leading: Text(
                        'Kích thước:',
                        style: PrimaryFont.instance.copyWith(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      title: Wrap(
                        runSpacing: 10.0,
                        spacing: 10.0,
                        children: product.properties!.sizes!
                            .map(
                              (e) => StreamBuilder<String>(
                                stream: bloc.sizeStream,
                                builder: (context, snapshot) {
                                  return InkWell(
                                    onTap: () => bloc.selectSize(e.toString()),
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: snapshot.data == e.toString()
                                            ? primaryColor
                                            : lightColor,
                                        border: snapshot.data == e.toString()
                                            ? null
                                            : Border.all(color: primaryColor),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          e.toString(),
                                          style: PrimaryFont.instance.copyWith(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w400,
                                            color: snapshot.data == e.toString()
                                                ? lightColor
                                                : darkColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                            .toList(),
                      ),
                    ),
              const Spacer(),
              Builder(builder: (context) {
                return Row(
                  children: [
                    Flexible(
                      child: ButtonWidget(
                        height: 40.0,
                        animate: true,
                        radius: 5.0,
                        btnColor: primaryColor,
                        onPressed: () => bloc.addToCart(context, product),
                        labelWidget: const Icon(
                          Icons.shopping_bag,
                          color: lightColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Flexible(
                      flex: 2,
                      child: ButtonWidget(
                        height: 40.0,
                        animate: true,
                        radius: 5.0,
                        btnColor: primaryColor,
                        onPressed: () {},
                        label: "Mua ngay",
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      );
    },
  );
}
