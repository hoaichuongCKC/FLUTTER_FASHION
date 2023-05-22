import 'package:flutter_fashion/app/blocs/order_cancel/order_cancel_cubit.dart';
import 'package:flutter_fashion/app/presentation/login/export.dart';
import 'package:flutter_fashion/app/presentation/order/components/awaiting_confirmation_page.dart';
import 'package:flutter_fashion/app/presentation/order/components/cancel_order.dart';
import 'package:flutter_fashion/app/presentation/order/components/delivered_page.dart';
import 'package:flutter_fashion/app/presentation/order/components/order_processing_page.dart';
import 'package:flutter_fashion/app/presentation/order/components/shipping_page.dart';
import 'package:flutter_fashion/app/presentation/order/constant.dart';

import '../../../common/components/app/background_app.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabBarController;

  @override
  void initState() {
    _tabBarController =
        TabController(length: ChoiceChipCustom.listData.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultTabController(
      length: ChoiceChipCustom.listData.length,
      child: AppBackgroundBlur.normal(
        isHasBackground: false,
        title: AppLocalizations.of(context)!.my_order,
        leading: InkWell(
          onTap: () => AppRoutes.router.go(Routes.PROFILE),
          child: const Icon(Icons.arrow_back, size: 24.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TabBar(
              splashBorderRadius: const BorderRadius.all(Radius.circular(5.0)),
              unselectedLabelColor: darkColor.withOpacity(0.5),
              indicatorSize: TabBarIndicatorSize.label,
              controller: _tabBarController,
              isScrollable: true,
              tabs: ChoiceChipCustom.listData
                  .map(
                    (e) => Tab(
                      child: Row(
                        children: [
                          e.prefixIcon,
                          const SizedBox(width: 3.0),
                          Text(
                            e.label.translateTabOrder(context),
                            style: theme.textTheme.bodyMedium!.copyWith(
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabBarController,
                children: const [
                  ToPay(),
                  OrderProcessingView(),
                  ShippingView(),
                  DeliveredView(),
                  CancelOrderView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
