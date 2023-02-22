import 'package:flutter/material.dart';
import 'package:flutter_fashion/config/colors.dart';
import 'package:flutter_fashion/config/constant.dart';
import 'package:flutter_fashion/config/font_style.dart';

class ButtonWidget extends StatefulWidget {
  const ButtonWidget({
    super.key,
    this.width = double.infinity,
    this.height = 50.0,
    this.btnColor,
    this.onPressed,
    this.label,
    this.labelWidget,
    this.boxShadow,
    this.animate = false,
  });
  final double width;
  final double height;
  final Color? btnColor;
  final VoidCallback? onPressed;
  final String? label;
  final Widget? labelWidget;
  final List<BoxShadow>? boxShadow;
  final bool animate;
  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  double get _width => widget.width;

  double get _height => widget.height;

  Color get _btnColor =>
      widget.btnColor != null ? widget.btnColor! : disablePrimaryColor;

  VoidCallback? get _onPressed => widget.onPressed;

  String? get _label => widget.label == null ? null : widget.label!;

  Widget? get _labelWidget => widget.labelWidget!;

  List<BoxShadow>? get _boxShadow => widget.boxShadow;

  bool get _animate => widget.animate;

  bool isScale = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !_animate ? _onPressed : null,
      onTapDown: !_animate
          ? null
          : (details) {
              isScale = true;
              setState(() {});
            },
      onTapUp: !_animate
          ? null
          : (details) {
              isScale = false;
              setState(() {});
              if (_onPressed != null) _onPressed!();
            },
      child: !_animate
          ? _buildBody()
          : AnimatedScale(
              duration: const Duration(milliseconds: 300),
              curve: Curves.linearToEaseOut,
              scale: isScale ? 0.95 : 1.0,
              child: _buildBody(),
            ),
    );
  }

  _buildBody() => DecoratedBox(
        decoration: BoxDecoration(
          color: _btnColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(radiusBtn),
          ),
          boxShadow: _onPressed == null ? null : _boxShadow,
        ),
        child: SizedBox(
          width: _width,
          height: _height,
          child: _label == null
              ? Align(child: _labelWidget)
              : Align(
                  child: Text(
                    _label!,
                    style: PrimaryFont.instance.copyWith(
                      color: _onPressed == null ? darkColor : lightColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 16.0,
                    ),
                  ),
                ),
        ),
      );
}
