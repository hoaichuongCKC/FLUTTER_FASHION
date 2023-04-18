// ignore_for_file: deprecated_member_use

import 'package:flutter_fashion/core/models/item_bottom_nav.dart';
import "package:flutter_fashion/export.dart";

final bottomData = [
  ItemBottomNavModel(path: Routes.HOME, urlIcon: "assets/icons/home.svg"),
  ItemBottomNavModel(
      path: Routes.NOTIFICATION, urlIcon: "assets/icons/notification.svg"),
  ItemBottomNavModel(path: Routes.PROFILE, urlIcon: "assets/icons/user1.svg"),
];

class BottomNavigationBarApp extends StatelessWidget {
  const BottomNavigationBarApp({super.key, required this.pagePath});
  final String pagePath;

  @override
  Widget build(BuildContext context) {
    late int currentPage;
    switch (pagePath) {
      case Routes.HOME:
        currentPage = 0;
        break;
      case Routes.NOTIFICATION:
        currentPage = 1;
        break;
      case Routes.PROFILE:
        currentPage = 2;
        break;
      default:
    }

    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.1,
      color: lightColor,
      constraints: const BoxConstraints(
        maxHeight: 50.0,
        minHeight: 45,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: bottomData.map(
              (e) {
                final index = bottomData.indexOf(e);
                return Expanded(
                  child: ItemNavigationBar(
                    isSelected: currentPage == index,
                    icon: AnimatedScale(
                      duration: const Duration(milliseconds: 450),
                      curve: Curves.bounceOut,
                      scale: currentPage == index ? 1.0 : 0.8,
                      child: SvgPicture.asset(
                        bottomData[index].urlIcon,
                        width: 20,
                        height: 20,
                        color: currentPage == index
                            ? primaryColor
                            : darkColor.withOpacity(0.5),
                      ),
                    ),
                    routes: bottomData[index].path,
                    onPressed: () {
                      currentPage = index;
                      AppRoutes.router.go(bottomData[index].path);
                    },
                  ),
                );
              },
            ).toList(),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 1.5,
              width: size.width * .4,
              decoration: const BoxDecoration(
                color: primaryColor,
                gradient: LinearGradient(
                  colors: [
                    disablePrimaryColor,
                    primaryColor,
                    disablePrimaryColor,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemNavigationBar extends StatelessWidget {
  const ItemNavigationBar({
    super.key,
    required this.icon,
    required this.routes,
    required this.onPressed,
    this.isSelected = false,
  });
  final Widget icon;
  final String routes;
  final VoidCallback onPressed;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(child: icon),
          const SizedBox(height: 4.0),
          Center(
            child: Text(
              routes.translateLabelBottomNavigationBar(context),
              style: PrimaryFont.instance.copyWith(
                fontSize: 10.0,
                color: isSelected ? primaryColor : darkColor.withOpacity(0.5),
                fontWeight: isSelected ? FontWeight.w400 : FontWeight.w300,
              ),
            ),
          )
        ],
      ),
    );
  }
}
