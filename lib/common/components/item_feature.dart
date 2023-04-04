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
          DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: model.color.withOpacity(0.2),
            ),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: SvgPicture.asset(
                model.imageUrl,
                width: 18.0,
                height: 18.0,
                fit: BoxFit.contain,
              ),
            ),
          ),
          model.path == Names.ORDER
              ? BlocSelector<OrderCubit, OrderState, bool>(
                  selector: (state) {
                    if (state.awaitingList.isNotEmpty) {
                      return true;
                    }
                    if (state.processingList.isNotEmpty) {
                      return true;
                    }
                    if (state.shippingList.isNotEmpty) {
                      return true;
                    }
                    return false;
                  },
                  builder: (context, hasData) {
                    if (!hasData) {
                      return const SizedBox();
                    }
                    return const Align(
                      alignment: Alignment(0.6, -0.9),
                      child: FractionallySizedBox(
                        heightFactor: 0.25,
                        widthFactor: 0.25,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: errorColor,
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
