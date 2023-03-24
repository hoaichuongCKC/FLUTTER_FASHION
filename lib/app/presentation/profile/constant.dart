import 'package:flutter/material.dart';
import 'package:flutter_fashion/core/models/profile_feature.dart';
import 'package:flutter_fashion/routes/app_routes.dart';

const String appUrlAssets = "assets/icons/profile/";

final List<ProfileFeatureModel> listFeatureFirst = [
  ProfileFeatureModel(
    label: "Cá nhân",
    imageUrl: "${appUrlAssets}personal_information.svg",
    path: Names.PERSONAL,
    color: const Color(0xFFC6B415),
  ),
  ProfileFeatureModel(
    label: "Đơn hàng",
    imageUrl: "${appUrlAssets}order.svg",
    path: Names.ORDER,
    color: const Color(0xFF39DF67),
  ),
  ProfileFeatureModel(
    label: "Địa chỉ",
    imageUrl: "assets/icons/map_address.svg",
    path: Routes.ADDRESS_MANAGEMENT,
    color: const Color(0xFFF23859),
  ),
];
final List<ProfileFeatureModel> listFeatureSecond = [
  ProfileFeatureModel(
    label: "Yêu thích",
    imageUrl: "assets/icons/favorite.svg",
    path: Names.FAVORITE,
    color: const Color(0xFFFF70F1),
  ),
  ProfileFeatureModel(
    label: "Cài đặt",
    imageUrl: "${appUrlAssets}setting.svg",
    path: Names.SETTING,
    color: const Color(0xFF8E8EEB),
  ),
  ProfileFeatureModel(
    label: "Tin nhắn",
    imageUrl: "${appUrlAssets}messenger.svg",
    path: Routes.MESSENGER,
    color: const Color(0xFF2B93F3),
  ),
];
