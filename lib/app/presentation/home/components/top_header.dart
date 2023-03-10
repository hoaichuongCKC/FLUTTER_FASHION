import 'package:flutter_fashion/app/presentation/home/export.dart';

class TopHeaderHome extends StatelessWidget {
  const TopHeaderHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
          horizontal: horizontalPadding - 4, vertical: 15.0),
      sliver: SliverToBoxAdapter(
        child: SafeArea(
          child: ConstrainedBoxWidget(
            currentHeight: 0.2,
            maxHeight: 70,
            minHeight: 60,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    'Chào mừng\nđến Kira Fashion!',
                    style: PrimaryFont.instance.copyWith(
                      fontSize: 22.0,
                      color: darkColor,
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () => AppRoutes.push(Routes.SEARCH),
                      icon: SvgPicture.asset("assets/icons/search.svg"),
                    ),
                    const SizedBox(width: 8.0),
                    InkWell(
                      onTap: () {},
                      child: SvgPicture.asset("assets/icons/cart.svg"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
