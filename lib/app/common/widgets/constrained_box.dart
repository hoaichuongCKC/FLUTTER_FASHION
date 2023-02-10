import 'package:flutter/material.dart';

class ConstrainedBoxWidget extends StatelessWidget {
  const ConstrainedBoxWidget({
    super.key,
    this.minWidth = 0.0,
    this.maxWidth = double.infinity,
    this.minHeight = 0.0,
    this.maxHeight = double.infinity,
    required this.currentHeight,
  }) : assert(currentHeight > 0.0 && currentHeight <= 1.0,
            "current height in range 0.0 to 1.0");
  final double minWidth;
  final double maxWidth;
  final double minHeight;
  final double maxHeight;
  final double currentHeight;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: minWidth,
        minHeight: minHeight,
        maxHeight: maxHeight,
        maxWidth: maxWidth,
      ),
      child: SizedBox(
        width: double.infinity,
        height: size.height * currentHeight,
      ),
    );
  }
}
