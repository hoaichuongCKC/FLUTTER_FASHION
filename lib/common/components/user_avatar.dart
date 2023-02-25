// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_fashion/app/presentation/introduction/export.dart';
import 'package:flutter_fashion/config/colors.dart';
import 'package:flutter_fashion/core/base/api/api.dart';

class UserAvatarApp extends StatelessWidget {
  const UserAvatarApp({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLight = Theme.of(context).brightness == Brightness.light;
    return DecoratedBox(
      decoration: BoxDecoration(
        border:
            Border.all(color: isLight ? primaryColor : lightColor, width: 0.7),
        shape: BoxShape.circle,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 90.0,
          minHeight: 80.0,
          minWidth: 80.0,
          maxWidth: 90.0,
        ),
        child: SizedBox(
          width: size.width * 0.3,
          height: size.width * 0.3,
          child: Padding(
            padding: const EdgeInsets.all(7.0),
            child: CircleAvatar(
              radius: 30.0,
              backgroundImage:
                  CachedNetworkImageProvider(ApiService.imageUrl + imageUrl),
            ),
          ),
        ),
      ),
    );
  }
}

class UserAvatarDefault extends StatelessWidget {
  const UserAvatarDefault({super.key, this.onPressed, this.child});
  final void Function()? onPressed;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onPressed,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: disablePrimaryColor,
          shape: BoxShape.circle,
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 130.0,
            minHeight: 100.0,
            minWidth: 100.0,
            maxWidth: 130.0,
          ),
          child: SizedBox(
            width: size.width * 0.5,
            height: size.width * 0.5,
            child: child ??
                Stack(
                  children: [
                    Align(
                      child: SvgPicture.asset(
                        "assets/icons/user1.svg",
                        fit: BoxFit.contain,
                        width: 60,
                        height: 60,
                        color: darkColor,
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 5,
                      child: SvgPicture.asset(
                        "assets/icons/camera.svg",
                        width: 20,
                        height: 20,
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
