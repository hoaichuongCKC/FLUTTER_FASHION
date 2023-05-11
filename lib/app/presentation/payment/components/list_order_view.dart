import 'package:flutter_fashion/app/blocs/cart/cart_cubit.dart';
import 'package:flutter_fashion/app/presentation/cart/components/item_cart.dart';

import '../../../../export.dart';

class ListOrderView extends StatelessWidget {
  const ListOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    final listCart = getIt.get<CartCubit>().state.items;
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            minLeadingWidth: 0.0,
            leading: SvgPicture.asset("assets/icons/order_box.svg"),
            title: Text(
              AppLocalizations.of(context)!.my_order,
              style: theme.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListView.separated(
            itemBuilder: (context, index) => ItemCart(
              index: index,
              item: listCart[index],
              isItemCart: false,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const SizedBox(height: 10.0),
            itemCount: listCart.length,
          )
        ],
      ),
    );
  }
}
