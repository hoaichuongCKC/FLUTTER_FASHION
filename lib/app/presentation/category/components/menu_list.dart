import 'package:flutter_fashion/app/blocs/category/category_cubit.dart';
import 'package:flutter_fashion/app/presentation/category/blocs/category_bloc.dart';
import '../../../../core/base/api/api.dart';
import '../../../../export.dart';

class MenuList extends StatelessWidget {
  const MenuList({super.key, required this.tabController});
  final TabController tabController;
  @override
  Widget build(BuildContext context) {
    final bloc = getIt.get<CategoryPageBloc>();

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
                  return Tab(
                    child: StreamBuilder<int>(
                        stream: bloc.categoryStream,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const SizedBox();
                          }
                          final bool isSelected = snapshot.data! == e.id;
                          return InkWell(
                            onTap: () {
                              tabController.animateTo(index,
                                  curve: Curves.easeIn,
                                  duration: const Duration(milliseconds: 400));
                              bloc.selectIdCate(e.id);
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
                                    e.name_vi,
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
                  // return ListView.separated(
                  //   padding: const EdgeInsets.symmetric(
                  //       horizontal: horizontalPadding - 4),
                  //   itemCount: dataList.length,
                  //   separatorBuilder: (context, index) =>
                  //       const SizedBox(width: 15.0),
                  //   scrollDirection: Axis.horizontal,
                  //   itemBuilder: (context, index) {
                  //     final data = dataList[index];
                  //     return StreamBuilder<int>(
                  //       stream: bloc.categoryStream,
                  //       builder: (context, snapshot) {
                  //         if (!snapshot.hasData) {
                  //           return const SizedBox();
                  //         }
                  //         final bool isSelected = snapshot.data! == data.id;
                  //         return Padding(
                  //           padding: const EdgeInsets.symmetric(vertical: 5.0),
                  //           child: InkWell(
                  //             onTap: () => bloc.selectIdCate(data.id),
                  //             child: DecoratedBox(
                  //               decoration: BoxDecoration(
                  //                 color: isSelected ? primaryColor : lightColor,
                  //                 borderRadius: const BorderRadius.all(
                  //                   Radius.circular(5.0),
                  //                 ),
                  //                 boxShadow: [
                  //                   BoxShadow(
                  //                     color: isSelected
                  //                         ? primaryColor.withOpacity(0.5)
                  //                         : disablePrimaryColor,
                  //                     blurRadius: 3.0,
                  //                     offset: const Offset(1, 0),
                  //                   )
                  //                 ],
                  //               ),
                  //               child: Padding(
                  //                 padding: const EdgeInsets.all(5.0),
                  //                 child: Row(
                  //                   children: [
                  //                     AspectRatio(
                  //                       aspectRatio: 1.0,
                  //                       child: CachedNetworkImage(
                  //                         imageUrl:
                  //                             ApiService.imageUrl + data.photo,
                  //                         fit: BoxFit.contain,
                  //                       ),
                  //                     ),
                  //                     const SizedBox(width: 5.0),
                  //                     Align(
                  //                       alignment: Alignment.centerLeft,
                  //                       child: Text(
                  //                         data.name_vi,
                  //                         maxLines: 2,
                  //                         style: PrimaryFont.instance.copyWith(
                  //                           fontSize: 16.0,
                  //                           color: isSelected
                  //                               ? lightColor
                  //                               : darkColor,
                  //                           fontWeight: FontWeight.w400,
                  //                           height: 1.2,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     const SizedBox(width: 5.0),
                  //                   ],
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         );
                  //       },
                  //     );
                  //   },
                  // );
                },
              ).toList(),
            ),
          )!;
        },
      ),
    );
  }
}
