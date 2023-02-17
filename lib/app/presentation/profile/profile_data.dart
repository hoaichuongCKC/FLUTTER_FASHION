import 'package:flutter/material.dart';
import 'package:flutter_fashion/app/models/user/user_model.dart';

class ProfileData extends InheritedWidget {
  final UserModel user;

  const ProfileData(this.user, {super.key, required super.child});

  static ProfileData? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ProfileData>();

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}
