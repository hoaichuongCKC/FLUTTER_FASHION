// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_fashion/config/colors.dart';
import 'package:flutter_fashion/config/font_style.dart';
import 'package:flutter_fashion/core/models/item_bottom_nav.dart';
import 'package:flutter_fashion/routes/app_routes.dart';
import 'package:flutter_svg/svg.dart';

final bottomData = [
  ItemBottomNavModel(
      path: Routes.HOME, label: 'Trang chủ', urlIcon: "assets/icons/home.svg"),
  ItemBottomNavModel(
      path: Routes.NOTIFICATION,
      label: 'Thông báo',
      urlIcon: "assets/icons/notification.svg"),
  ItemBottomNavModel(
      path: Routes.PROFILE, label: 'Tôi', urlIcon: "assets/icons/user1.svg"),
];

class BottomNavigationBarApp extends StatefulWidget {
  const BottomNavigationBarApp({super.key, required this.pagePath});
  final String pagePath;
  @override
  State<BottomNavigationBarApp> createState() => _BottomNavigationBarAppState();
}

class _BottomNavigationBarAppState extends State<BottomNavigationBarApp> {
  late int currentPage;

  @override
  void initState() {
    super.initState();
    _initCurrentPage();
  }

  void _initCurrentPage() {
    switch (widget.pagePath) {
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
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.1,
      color: lightColor,
      constraints: const BoxConstraints(
        maxHeight: 70.0,
        minHeight: 60,
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
                        width: 25,
                        height: 25,
                        color: currentPage == index
                            ? primaryColor
                            : darkColor.withOpacity(0.5),
                      ),
                    ),
                    label: bottomData[index].label,
                    onPressed: () {
                      currentPage = index;
                      AppRoutes.goShellKey(bottomData[index].path);
                      setState(() {});
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
    required this.label,
    required this.onPressed,
    this.isSelected = false,
  });
  final Widget icon;
  final String label;
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
          const SizedBox(height: 7.0),
          Center(
            child: Text(
              label,
              style: PrimaryFont.instance.copyWith(
                fontSize: 12.0,
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
