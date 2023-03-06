import 'package:flutter/material.dart';

class AppContext {
  AppContext._();

  late BuildContext context;

  static AppContext instance = AppContext._();

  BuildContext get getContext => context;
}
