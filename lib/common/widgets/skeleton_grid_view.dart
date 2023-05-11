import '../../export.dart';

class SkeletonGridView extends StatelessWidget {
  const SkeletonGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 6,
      // controller: _scrollController,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 2 / 4,
        mainAxisExtent: 220.0,
      ),
      itemBuilder: (context, index) {
        return ColoredBox(
          color: ThemeDataApp.instance.isLight
              ? skeletonColor
              : Theme.of(context).cardColor,
        );
      },
    );
  }
}
