import 'package:flutter_fashion/app/blocs/category/category_cubit.dart';
import 'package:flutter_fashion/app/models/category/category.dart';
import 'package:flutter_fashion/app/presentation/category/blocs/category_tab_cubit.dart';
import '../../../../export.dart';

class MenuList extends StatelessWidget {
  const MenuList({super.key, required this.tabController});

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isVietnamese = context.watch<SettingsCubit>().state.isVietnamese;

    final categories = InheritedDataApp.of<List<CategoryModel>>(context)!.data;

    final bloc = context.read<CategoryTabCubit>();

    return SizedBox(
      width: double.maxFinite,
      height: 45,
      child: TabBar(
        controller: tabController,
        isScrollable: true,
        labelColor: lightColor,
        indicatorSize: TabBarIndicatorSize.tab,
        padding: const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
        labelStyle: theme.textTheme.bodySmall!.copyWith(
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
        ),
        onTap: (index) {
          bloc.changeTab(categories[index].id);
        },
        indicator: const BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(
              radiusBtn,
            ),
          ),
        ),
        tabs: categories.map(
          (e) {
            final subtitle = isVietnamese ? e.name_vi : e.name;

            return Tab(
              text: subtitle,
            );
          },
        ).toList(),
      ),
    );
  }
}
