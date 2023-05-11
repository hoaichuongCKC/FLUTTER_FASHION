// ignore_for_file: deprecated_member_use
import 'package:flutter_fashion/app/presentation/location_management/components/show_action.dart';
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
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => showAction(
        context,
        onDelete,
        onUseDefault,
        item.isSelected,
      ),
      child: ConstrainedBoxWidget(
        currentHeight: 0.11,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: const BorderRadius.all(Radius.circular(radiusBtn)),
            boxShadow: !ThemeDataApp.instance.isLight
                ? null
                : [
                    const BoxShadow(
                        color: disablePrimaryColor, blurRadius: 8.0),
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
                    width: 20.0,
                    height: 20.0,
                    color: primaryColor,
                    fit: BoxFit.contain,
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
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            item.name,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 14.0,
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
                                  AppLocalizations.of(context)!.in_use,
                                  style: PrimaryFont.instance.copyWith(
                                    fontSize: 10.0,
                                    color: lightColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            secondChild: ColoredBox(
                              color: ThemeDataApp.instance.isLight
                                  ? disablePrimaryColor
                                  : theme.cardColor,
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text(
                                  AppLocalizations.of(context)!.not_in_use,
                                  style: PrimaryFont.instance.copyWith(
                                    fontSize: 10.0,
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
