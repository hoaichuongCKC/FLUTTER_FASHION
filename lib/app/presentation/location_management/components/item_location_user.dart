// ignore_for_file: deprecated_member_use

import 'package:flutter_fashion/app/blocs/address_user/address_user_cubit.dart';
import 'package:flutter_fashion/core/models/address.dart';

import '../../../../export.dart';

class ItemLocationUser extends StatelessWidget {
  const ItemLocationUser({
    super.key,
    required this.item,
    required this.onDelete,
    required this.onUseDefault,
  });
  final ItemAddress item;
  final VoidCallback onDelete;
  final VoidCallback onUseDefault;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        showAction(
          context,
          onDelete,
          onUseDefault,
        );
      },
      child: ConstrainedBoxWidget(
        currentHeight: 0.13,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: lightColor,
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            boxShadow: [
              BoxShadow(color: disablePrimaryColor, blurRadius: 8.0),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset(
                    "assets/icons/map_address.svg",
                    width: 24.0,
                    height: 24.0,
                    color: primaryColor,
                    fit: BoxFit.cover,
                    placeholderBuilder: (context) => ColoredBox(
                      color: skeletonColor,
                      child: const SizedBox(
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            item.name,
                            style: PrimaryFont.instance.copyWith(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w300,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        AnimatedCrossFade(
                            key: ValueKey(item.name),
                            firstChild: ColoredBox(
                              color: successfullyColor,
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text(
                                  'Đang sử dụng',
                                  style: PrimaryFont.instance.copyWith(
                                    fontSize: 12.0,
                                    color: lightColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            secondChild: ColoredBox(
                              color: disablePrimaryColor,
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text(
                                  'Không được sử dụng',
                                  style: PrimaryFont.instance.copyWith(
                                    fontSize: 12.0,
                                    color: lightColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            crossFadeState: item.isSelected
                                ? CrossFadeState.showFirst
                                : CrossFadeState.showSecond,
                            firstCurve: Curves.linearToEaseOut,
                            secondCurve: Curves.linearToEaseOut,
                            duration: const Duration(milliseconds: 450)),
                      ],
                    ),
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

void showAction(
  BuildContext context,
  VoidCallback onDelete,
  VoidCallback onUse,
) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(5),
        topRight: Radius.circular(5),
      ),
    ),
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(
            vertical: verticalPadding / 2, horizontal: horizontalPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ButtonWidget(
              btnColor: lightColor,
              height: 45.0,
              animate: true,
              onPressed: onUse,
              radius: 5.0,
              labelWidget: Text(
                'Sử dụng',
                style: PrimaryFont.instance.copyWith(
                  fontSize: 16.0,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            ButtonWidget(
              btnColor: lightColor,
              height: 45.0,
              animate: true,
              onPressed: onDelete,
              radius: 5.0,
              labelWidget: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/icons/trash.svg",
                    width: 20,
                    height: 20,
                    color: primaryColor,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    'Xoá',
                    style: PrimaryFont.instance.copyWith(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
