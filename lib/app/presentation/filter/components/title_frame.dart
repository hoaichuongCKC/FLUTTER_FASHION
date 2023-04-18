import 'package:flutter_fashion/export.dart';

class TitleFilterFrame extends StatelessWidget {
  const TitleFilterFrame({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBoxWidget(
      currentHeight: 0.07,
      maxHeight: 45.0,
      minHeight: 40.0,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: disablePrimaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        child: Align(
          alignment: const Alignment(-.9, 0),
          child: Text(
            title,
            style: PrimaryFont.instance.copyWith(
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}
