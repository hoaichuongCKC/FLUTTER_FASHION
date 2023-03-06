import 'package:flutter/material.dart';
import 'package:flutter_fashion/config/colors.dart';
import 'package:flutter_fashion/config/font_style.dart';

class CounterCart extends StatefulWidget {
  const CounterCart({super.key});

  @override
  State<CounterCart> createState() => _CounterCartState();
}

class _CounterCartState extends State<CounterCart> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: disableDarkColor,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.arrow_left_outlined,
            size: 20,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Text(
            '1',
            style: PrimaryFont.instance.small(),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            color: disableDarkColor,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.arrow_right_outlined,
            size: 20,
          ),
        ),
      ],
    );
  }
}
