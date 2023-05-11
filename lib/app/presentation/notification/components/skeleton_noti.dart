import '../../../../export.dart';

class SkeletonNotification extends StatelessWidget {
  const SkeletonNotification({super.key});

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
      child: Column(
        children: List.generate(
          5,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: ColoredBox(
              color: isLight ? skeletonColor : Theme.of(context).cardColor,
              child: SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * .15,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
