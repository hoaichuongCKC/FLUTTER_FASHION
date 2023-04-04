import '../../../../export.dart';

class SkeletonNotification extends StatelessWidget {
  const SkeletonNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        5,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: ColoredBox(
            color: skeletonColor,
            child: const SizedBox(
              width: double.infinity,
              height: 130.0,
            ),
          ),
        ),
      ),
    );
  }
}
