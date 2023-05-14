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
        decoration: BoxDecoration(
          color: ThemeDataApp.instance.isLight
              ? secondaryColor.withAlpha(50)
              : Theme.of(context).cardColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        child: Align(
          alignment: const Alignment(-.9, 0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }
}
