import 'package:flutter_fashion/app/presentation/home/export.dart';

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
    this.radius = radiusBtn,
    this.outlineButton = false,
  }) : assert(!(label != null && labelWidget != null),
            'Địt con mẹ cái gì thế tại sao có hai tham số');
  final double width;
  final double height;
  final Color? btnColor;
  final VoidCallback? onPressed;
  final String? label;
  final Widget? labelWidget;
  final List<BoxShadow>? boxShadow;
  final bool animate;
  final bool? outlineButton;
  final double? radius;
  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  double get _width => widget.width;

  double get _height => widget.height;

  Color get _btnColor => widget.btnColor ?? disablePrimaryColor;

  VoidCallback? get _onPressed => widget.onPressed;

  String? get _label => widget.label == null ? null : widget.label!;

  Widget? get _labelWidget => widget.labelWidget!;

  List<BoxShadow>? get _boxShadow => widget.boxShadow;

  bool get _animate => widget.animate;

  bool isScale = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
          ? _buildBody(theme)
          : AnimatedScale(
              duration: const Duration(milliseconds: 300),
              curve: Curves.linearToEaseOut,
              scale: isScale ? 0.95 : 1.0,
              child: _buildBody(theme),
            ),
    );
  }

  _buildBody(ThemeData theme) => DecoratedBox(
        decoration: BoxDecoration(
          color: widget.outlineButton! ? lightColor : _btnColor,
          borderRadius: BorderRadius.all(
            Radius.circular(widget.radius!),
          ),
          border:
              widget.outlineButton! ? Border.all(color: primaryColor) : null,
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
                      fontSize: 14.0,
                      fontWeight: FontWeight.w300,
                      color: ThemeDataApp.instance.isLight
                          ? lightColor
                          : darkColor,
                    ),
                  ),
                ),
        ),
      );
}
