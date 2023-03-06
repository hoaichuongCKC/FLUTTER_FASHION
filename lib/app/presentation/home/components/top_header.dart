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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      'Welcome,\nSherlock Holmes!',
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
                      SvgPicture.asset("assets/icons/cart.svg"),
                    ],
                  )
                ],
              ),
              ListTile(
                dense: true,
                onTap: () => AppRoutes.push(Routes.SEARCHLOCATION),
                contentPadding: EdgeInsets.zero,
                horizontalTitleGap: 6.0,
                leading: SvgPicture.asset("assets/icons/map_address.svg"),
                title: Text(
                  'Update your address....',
                  style: PrimaryFont.instance.copyWith(
                    fontSize: 16.0,
                    color: darkColor.withOpacity(0.6),
                    fontWeight: FontWeight.w300,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
