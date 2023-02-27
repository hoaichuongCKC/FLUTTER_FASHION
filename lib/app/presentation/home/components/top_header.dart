import 'package:flutter/material.dart';
import 'package:flutter_fashion/config/colors.dart';
import 'package:flutter_fashion/config/constant.dart';
import 'package:flutter_fashion/config/font_style.dart';
import 'package:flutter_svg/svg.dart';

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
                      SvgPicture.asset("assets/icons/search.svg"),
                      const SizedBox(width: 8.0),
                      SvgPicture.asset("assets/icons/cart.svg"),
                    ],
                  )
                ],
              ),
              ListTile(
                dense: true,
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
