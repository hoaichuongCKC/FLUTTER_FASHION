// ignore_for_file: deprecated_member_use

import 'package:flutter_fashion/app/presentation/category/blocs/category_bloc.dart';
import 'package:flutter_fashion/app/presentation/category/components/menu_list.dart';
import 'package:flutter_fashion/app/presentation/category/components/product_list.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/common/components/app/background_app.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key, required this.searchKey, required this.item});
  final String searchKey;
  final String item;
  @override
  Widget build(BuildContext context) {
    final bloc = getIt<CategoryPageBloc>();
    bloc.selectIdCate(int.parse(item));
    return AppBackgroundBlur.withAppBar(
      actions: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () => AppRoutes.router.pushNamed(Names.SEARCH),
              child: FractionallySizedBox(
                heightFactor: 0.7,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: lightColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                    boxShadow: [BoxShadow(color: darkColor.withOpacity(0.15))],
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: SvgPicture.asset(
                          "assets/icons/search.svg",
                          color: darkColor.withOpacity(0.5),
                        ),
                      ),
                      Text(
                        "Tìm kiếm",
                        style: PrimaryFont.instance.copyWith(
                          fontSize: 14.0,
                          color: darkColor.withOpacity(0.5),
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          MenuList(),
          Expanded(child: ProductList()),
        ],
      ),
    );
  }
}
