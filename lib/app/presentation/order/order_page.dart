import 'package:flutter_fashion/app/presentation/login/export.dart';
import 'package:flutter_fashion/app/presentation/order/constant.dart';

import '../../../common/components/app/background_app.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  int _index = 0;
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBackgroundBlur.normal(
      title: 'Đơn hàng của tôi',
      leading: InkWell(
        onTap: () => AppRoutes.router.go(Routes.PROFILE),
        child: const Icon(Icons.arrow_back, size: 20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            key: const PageStorageKey("tab-order"),
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: ChoiceChipCustom.listData.map(
                    (e) {
                      final index = ChoiceChipCustom.listData.indexOf(e);
                      // final globalKey = GlobalKey();
                      return Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: ChoiceChip(
                          key: ValueKey("$index"),
                          onSelected: (value) {
                            _index = index;
                            setState(() {});
                          },
                          materialTapTargetSize: MaterialTapTargetSize.padded,
                          side: BorderSide.none,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(14.0),
                            ),
                            side: BorderSide.none,
                          ),
                          label: Text(
                            e.label,
                            style: PrimaryFont.instance.copyWith(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          selected: _index == index,
                          elevation: 0.0,
                          selectedColor: primaryColor.withOpacity(0.3),
                          disabledColor: disableDarkColor.withOpacity(0.1),
                        ),
                      );
                    },
                  ).toList()),
            ),
          ),
        ],
      ),
    );
  }
}
