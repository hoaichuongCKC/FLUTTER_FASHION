import 'package:flutter_fashion/app/presentation/cart/components/item_cart.dart';

import '../../../../config/svg_files.dart';
import '../../../../export.dart';

class ListOrderView extends StatelessWidget {
  const ListOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    final listCart = getIt.get<CartCubit>().state.items;
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          minLeadingWidth: 0.0,
          leading: SvgPicture.asset(
            Assets.orderBoxSVG,
          ),
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
    );
  }
}
