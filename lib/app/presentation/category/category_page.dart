import 'package:flutter_fashion/app/presentation/category/blocs/category_bloc.dart';
import 'package:flutter_fashion/app/presentation/category/components/menu_list.dart';
import 'package:flutter_fashion/app/presentation/category/components/product_list.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/common/components/app/background_app.dart';
import 'package:flutter_fashion/common/components/form_search.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key, required this.searchKey, required this.item});
  final String searchKey;
  final String item;
  @override
  Widget build(BuildContext context) {
    final bloc = getIt<CategoryPageBloc>();
    bloc.selectIdCate(int.parse(item));
    return AppBackgroundBlur.normal(
      title: "Danh mục",
      actionsSecond: [
        TextButton.icon(
          onPressed: () => AppRoutes.router.pushNamed(Names.FILTER),
          label: Text(
            'Bộ lọc',
            style: PrimaryFont.instance.copyWith(
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          icon: SvgPicture.asset("assets/icons/filter.svg"),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormSearch(onChanged: (value) {}),
          const SizedBox(height: 10.0),
          const MenuList(),
          const Expanded(child: ProductList()),
        ],
      ),
    );
  }
}
