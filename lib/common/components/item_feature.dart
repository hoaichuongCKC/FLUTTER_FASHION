import 'package:flutter/material.dart';
import 'package:flutter_fashion/core/models/profile_feature.dart';
import 'package:flutter_svg/svg.dart';

class ItemFeatureProfile extends StatelessWidget {
  const ItemFeatureProfile({super.key, required this.model});
  final ProfileFeatureModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: model.color.withOpacity(0.1),
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: model.color.withOpacity(0.2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: SvgPicture.asset(
            model.imageUrl,
            width: 18.0,
            height: 18.0,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
