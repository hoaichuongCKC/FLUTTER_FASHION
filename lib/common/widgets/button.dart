import 'package:flutter_fashion/app/presentation/modules/user/home/export.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    this.height = 48.0,
    this.width = double.maxFinite,
    this.onPressed,
    required this.child,
    this.elevation = 8.0,
    this.background,
  });
  final double height;
  final double width;
  final VoidCallback? onPressed;
  final Widget child;
  final Color? background;
  final double elevation;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          overlayColor:
              MaterialStatePropertyAll(skeletonColor.withOpacity(0.1)),
          shadowColor: MaterialStatePropertyAll(darkColor.withOpacity(0.1)),
          elevation: MaterialStatePropertyAll(elevation),
          backgroundColor: MaterialStatePropertyAll(background ?? blackColor),
        ),
        child: child,
      ),
    );
  }
}
