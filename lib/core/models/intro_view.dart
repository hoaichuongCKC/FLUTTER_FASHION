// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_svg/svg.dart';

class IntroViewModel {
  final SvgPicture image;
  final String title;
  final String subtitle;
  final String titleEn;
  final String subtitleEn;
  IntroViewModel({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.titleEn,
    required this.subtitleEn,
  });
}
