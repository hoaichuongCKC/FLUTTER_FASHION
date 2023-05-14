import 'package:flutter_fashion/export.dart';

class FlashSaleWidget extends StatelessWidget {
  const FlashSaleWidget({super.key, this.size = 12.0});
  final double size;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1.0),
      color: errorColor,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            flex: 2,
            child: FittedBox(
              child: SvgPicture.asset(
                "assets/icons/flash.svg",
                fit: BoxFit.scaleDown,
                width: size,
                height: size,
                colorFilter:
                    const ColorFilter.mode(lightColor, BlendMode.srcIn),
              ),
            ),
          ),
          Flexible(
            flex: 4,
            child: FittedBox(
              child: Text(
                "Flash sale",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 10.0,
                      color: lightColor,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
