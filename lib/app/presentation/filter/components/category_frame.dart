import 'package:flutter_fashion/app/models/category/category.dart';
import 'package:flutter_fashion/app/presentation/filter/blocs/filter_bloc.dart';
import 'package:flutter_fashion/app/presentation/filter/components/title_frame.dart';
import '../../../../export.dart';

class CategoryFrame extends StatelessWidget {
  const CategoryFrame({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = getIt<FilterBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleFilterFrame(title: "Loại sản phẩm"),
        const SizedBox(height: 8.0),
        StreamBuilder<List<CategoryModel>>(
          stream: bloc.buildCateStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            }
            return Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              alignment: WrapAlignment.start,
              spacing: 0.0,
              runSpacing: 20.0,
              children: snapshot.data!.map(
                (e) {
                  final index = snapshot.data!.indexOf(e);
                  if (index == 0) {
                    return const SizedBox();
                  }
                  return StreamBuilder<int>(
                    stream: bloc.selectCateStream,
                    builder: (context, snapshotSecond) {
                      if (!snapshotSecond.hasData) {
                        return const SizedBox();
                      }
                      return _buildItem(
                        title: e.name_vi,
                        isSelected: snapshotSecond.data! == index,
                        onTap: () => bloc.selectCate(index),
                      );
                    },
                  );
                },
              ).toList(),
            );
          },
        ),
      ],
    );
  }

  InkWell _buildItem(
      {String title = "",
      bool isSelected = false,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: primaryColor),
              ),
              child: AnimatedCrossFade(
                duration: const Duration(milliseconds: 450),
                secondChild: const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: SizedBox(
                    width: 15,
                    height: 15,
                  ),
                ),
                firstChild: const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: primaryColor,
                    ),
                    child: SizedBox(
                      width: 15,
                      height: 15,
                    ),
                  ),
                ),
                firstCurve: Curves.easeIn,
                secondCurve: Curves.easeIn,
                crossFadeState: isSelected
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
              ),
            ),
            const SizedBox(width: 8.0),
            Text(
              title,
              style: PrimaryFont.instance.copyWith(
                fontSize: 14.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
