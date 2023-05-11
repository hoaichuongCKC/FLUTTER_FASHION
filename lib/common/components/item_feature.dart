import 'package:flutter_fashion/app/blocs/order/order_cubit.dart';
import 'package:flutter_fashion/core/models/profile_feature.dart';

import '../../export.dart';

class ItemFeatureProfile extends StatelessWidget {
  const ItemFeatureProfile({super.key, required this.model});
  final ProfileFeatureModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: model.color.withOpacity(0.1),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: SvgPicture.asset(
              model.imageUrl,
              width: 18.0,
              height: 18.0,
              fit: BoxFit.contain,
            ),
          ),
          model.path == Names.ORDER
              ? BlocSelector<OrderCubit, OrderState, bool>(
                  selector: (state) {
                    if (state.toPayList.isNotEmpty) {
                      return true;
                    }
                    if (state.toShipList.isNotEmpty) {
                      return true;
                    }
                    if (state.toReceiveList.isNotEmpty) {
                      return true;
                    }
                    return false;
                  },
                  builder: (context, hasData) {
                    if (!hasData) {
                      return const SizedBox();
                    }
                    return Align(
                      alignment: const Alignment(0.8, -0.9),
                      child: FractionallySizedBox(
                        heightFactor: 0.15,
                        widthFactor: 0.15,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: errorColor.withOpacity(0.8),
                          ),
                        ),
                      ),
                    );
                  },
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
