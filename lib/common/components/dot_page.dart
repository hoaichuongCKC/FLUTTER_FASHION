import 'package:flutter/material.dart';
import 'package:flutter_fashion/config/colors.dart';

class DotPage extends StatelessWidget {
  const DotPage(
      {super.key,
      required this.length,
      this.activeColor = secondaryColor,
      this.disableDot = darkColor,
      required this.currentDot});
  final int length;
  final Color? activeColor;
  final Color? disableDot;
  final int currentDot;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < length; ++i)
          AnimatedContainer(
            padding: EdgeInsets.only(right: i == length - 1 ? 0 : 7.0),
            duration: const Duration(milliseconds: 400),
            width: 22,
            height: 15,
            decoration: ShapeDecoration(
              shape: currentDot == i
                  ? const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    )
                  : const CircleBorder(),
              color:
                  currentDot == i ? activeColor : disableDot!.withOpacity(0.25),
            ),
          )
      ],
    );
  }
}
