import 'package:flutter_fashion/app/blocs/category/category_cubit.dart';
import 'package:flutter_fashion/app/presentation/category/blocs/category_tab_cubit.dart';
import '../../../../core/base/api/api.dart';
import '../../../../export.dart';

class MenuList extends StatelessWidget {
  const MenuList({super.key, required this.tabController});

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 45,
      child: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          return state.whenOrNull(
            fetchCompleted: (dataList) => TabBar(
              controller: tabController,
              isScrollable: true,
              tabs: dataList.map(
                (e) {
                  final index = dataList.indexOf(e);
                  final isVietnamese =
                      context.watch<LanguageCubit>().state.isVietnamese;
                  final subtitle = isVietnamese ? e.name_vi : e.name;
                  return Tab(
                    child: BlocBuilder<CategoryTabCubit, CategoryTabState>(
                        buildWhen: (previous, current) =>
                            previous.currentId != current.currentId,
                        builder: (context, state) {
                          final bool isSelected = state.currentId == e.id;
                          return InkWell(
                            onTap: () {
                              if (isSelected) return;

                              tabController.animateTo(index,
                                  curve: Curves.easeIn,
                                  duration: const Duration(milliseconds: 400));
                              context.read<CategoryTabCubit>().changeTab(e.id);
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                FractionallySizedBox(
                                  heightFactor: 0.8,
                                  child: AspectRatio(
                                    aspectRatio: 1.0,
                                    child: CachedNetworkImage(
                                      imageUrl: ApiService.imageUrl + e.photo,
                                      fit: BoxFit.scaleDown,
                                      cacheKey: e.photo,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5.0),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    subtitle,
                                    maxLines: 2,
                                    style: PrimaryFont.instance.copyWith(
                                      fontSize: 16.0,
                                      color:
                                          isSelected ? primaryColor : darkColor,
                                      fontWeight: FontWeight.w400,
                                      height: 1.2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  );
                },
              ).toList(),
            ),
          )!;
        },
      ),
    );
  }
}
