import 'package:flutter/material.dart';
import 'package:flutter_fashion/app/core/config/colors.dart';
import 'package:flutter_fashion/app/core/config/constant.dart';
import 'package:flutter_fashion/app/core/config/font_style.dart';

class ButtonWidget extends StatefulWidget {
  const ButtonWidget({
    super.key,
    this.width = double.infinity,
    this.height = 50.0,
    this.btnColor = primaryColor,
    required this.onPressed,
    this.label,
    this.labelWidget,
    this.boxShadow,
  });
  final double width;
  final double height;
  final Color btnColor;
  final VoidCallback onPressed;
  final String? label;
  final Widget? labelWidget;
  final List<BoxShadow>? boxShadow;
  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  double get _width => widget.width;

  double get _height => widget.height;

  Color get _btnColor => widget.btnColor;

  VoidCallback get _onPressed => widget.onPressed;

  String? get _label => widget.label == null ? null : widget.label!;

  Widget? get _labelWidget => widget.labelWidget!;

  List<BoxShadow>? get _boxShadow => widget.boxShadow;

  bool isScale = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        isScale = true;
        setState(() {});
      },
      onTapUp: (details) {
        isScale = false;
        setState(() {});
        _onPressed();
      },
      child: AnimatedScale(
        duration: const Duration(milliseconds: 300),
        curve: Curves.linearToEaseOut,
        scale: isScale ? 0.95 : 1.0,
        child: Container(
          width: _width,
          height: _height,
          decoration: BoxDecoration(
            color: _btnColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(radiusBtn),
            ),
            boxShadow: _boxShadow,
          ),
          alignment: Alignment.center,
          child: _label == null
              ? _labelWidget
              : Text(
                  _label!,
                  style: PrimaryFont.instance.copyWith(
                    color: lightColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 16.0,
                  ),
                ),
        ),
      ),
    );
  }
}
