import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fashion/config/colors.dart';

class UserAvatarApp extends StatelessWidget {
  const UserAvatarApp({super.key, required this.imageUrl});
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor, width: 0.7),
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
              backgroundImage: CachedNetworkImageProvider(imageUrl),
            ),
          ),
        ),
      ),
    );
  }
}
