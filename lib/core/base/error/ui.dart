import 'package:flutter/material.dart';
import 'package:flutter_fashion/config/colors.dart';
import 'package:flutter_fashion/config/font_style.dart';

class UIError extends StatelessWidget {
  const UIError({super.key, required this.error});

  final String error;
  @override
  Widget build(BuildContext context) {
    return Text(
      error,
      style: PrimaryFont.instance.copyWith(
        fontSize: 16.0,
        color: errorColor,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
