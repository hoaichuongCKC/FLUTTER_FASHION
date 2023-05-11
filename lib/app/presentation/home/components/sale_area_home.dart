import 'package:flutter_fashion/export.dart';
import 'package:slide_countdown/slide_countdown.dart';

const defaultDuration = Duration(days: 2, hours: 2, minutes: 30);
const defaultPadding = EdgeInsets.symmetric(horizontal: 10, vertical: 5);

class SaleAreaHome extends StatelessWidget {
  const SaleAreaHome({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: horizontalPadding - 4, vertical: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(5.0),
                  decoration: const BoxDecoration(
                    color: errorColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(radiusBtn / 3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/flash.svg",
                        colorFilter:
                            const ColorFilter.mode(lightColor, BlendMode.srcIn),
                      ),
                      Text(
                        "Flash sale",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              color: lightColor,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10.0),
                SlideCountdownSeparated(
                  duration: defaultDuration,
                  padding: defaultPadding,
                  textDirection: TextDirection.ltr,
                  separatorType: SeparatorType.symbol,
                  slideDirection: SlideDirection.up,
                  separator: ":",
                  durationTitle: DurationTitle.en(),
                  textStyle: theme.textTheme.bodySmall!.copyWith(
                    color: lightColor,
                  ),
                  separatorStyle: theme.textTheme.bodySmall!.copyWith(
                    color: darkColor,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
