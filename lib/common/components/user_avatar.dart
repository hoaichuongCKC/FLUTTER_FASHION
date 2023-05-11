// ignore_for_file: deprecated_member_use

import 'package:flutter_fashion/core/base/api/api.dart';

import '../../export.dart';

class UserAvatarApp extends StatelessWidget {
  const UserAvatarApp({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final bool isLight = theme.brightness == Brightness.light;
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 80.0,
        minHeight: 65.0,
        maxWidth: 80.0,
        minWidth: 65.0,
      ),
      child: SizedBox(
        width: size.width * 0.25,
        height: size.width * 0.25,
        child: imageUrl.isNotEmpty
            ? AspectRatio(
                aspectRatio: 1.0,
                child: CircleAvatar(
                  radius: 70.0,
                  backgroundImage: CachedNetworkImageProvider(
                    ApiService.imageUrl + imageUrl,
                    headers: getIt<ApiService>().headers,
                    cacheKey: ApiService.imageUrl + imageUrl,
                  ),
                ),
              )
            : Stack(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Align(
                        child: SvgPicture.asset(
                          "assets/icons/user1.svg",
                          fit: BoxFit.contain,
                          color: isLight
                              ? darkColor.withOpacity(0.7)
                              : lightColor.withOpacity(0.7),
                          width: 40,
                          height: 40,
                        ),
                      )),
                ],
              ),
      ),
    );
  }
}

class UserAvatarDefault extends StatelessWidget {
  const UserAvatarDefault(
      {super.key, this.onPressed, this.child, this.isCamera = true});
  final void Function()? onPressed;
  final Widget? child;
  final bool isCamera;
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
                    !isCamera
                        ? const SizedBox()
                        : Positioned(
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
