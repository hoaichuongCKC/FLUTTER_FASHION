import 'package:flutter_fashion/app/models/category/category.dart';
import 'package:flutter_fashion/app/presentation/filter/components/title_frame.dart';
import 'package:flutter_fashion/app/presentation/filter/cubit/filter_cubit.dart';
import '../../../../export.dart';

class CategoryFrame extends StatelessWidget {
  const CategoryFrame({super.key});

  @override
  Widget build(BuildContext context) {
    final filterCubit = context.read<FilterCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleFilterFrame(title: AppLocalizations.of(context)!.product_type),
        const SizedBox(height: 8.0),
        BlocBuilder<LanguageCubit, LanguageState>(
          builder: (context, state) {
            final isVietnamese = state.isVietnamese;

            return BlocBuilder<FilterCubit, FilterState>(
              buildWhen: (previous, current) =>
                  previous.categoryId != current.categoryId,
              builder: (context, state) {
                final categories = state.categories;

                final categorySelected = state.categoryId;
                return Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  alignment: WrapAlignment.start,
                  spacing: 0.0,
                  runSpacing: 20.0,
                  children: categories.map(
                    (e) {
                      final index = categories.indexOf(e);

                      if (index == 0) {
                        return const SizedBox();
                      }

                      final text = isVietnamese ? e.name_vi : e.name;
                      return _buildItem(
                        title: text,
                        isSelected: e.id == categorySelected,
                        onTap: () => filterCubit.changeCategory(e.id),
                      );
                    },
                  ).toList(),
                );
              },
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
