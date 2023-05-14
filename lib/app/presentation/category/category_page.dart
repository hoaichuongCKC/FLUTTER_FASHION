import 'package:flutter_fashion/app/models/category/category.dart';
import 'package:flutter_fashion/app/presentation/category/blocs/category_tab_cubit.dart';
import 'package:flutter_fashion/app/presentation/category/components/menu_list.dart';
import 'package:flutter_fashion/app/presentation/category/components/product_list.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/common/components/app/background_app.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({
    super.key,
    required this.index,
  });
  final int index;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with SingleTickerProviderStateMixin {
  final bloc = getIt.get<CategoryCubit>();

  late TabController _tabController;

  final tabAll = const CategoryModel(
    id: -1,
    name: "All",
    name_vi: "Tất cả",
  );

  late List<CategoryModel> _categories;

  @override
  void initState() {
    super.initState();

    _categories = [tabAll, ...bloc.categories];

    _tabController = TabController(vsync: this, length: _categories.length)
      ..animateTo(widget.index);

    if (widget.index.compareTo(0) == 0) {
      context.read<CategoryTabCubit>().changeTab(_categories[0].id);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _categories.length,
      child: InheritedDataApp<List<CategoryModel>>(
        data: _categories,
        child: AppBackgroundBlur.withAppBar(
          actions: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GestureDetector(
                  onTap: () => AppRoutes.router.pushNamed(Names.SEARCH),
                  child: FractionallySizedBox(
                    heightFactor: .9,
                    widthFactor: 0.95,
                    alignment: Alignment.centerRight,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: ThemeDataApp.instance.isLight
                            ? lightColor
                            : Theme.of(context).cardColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(radiusBtn + 10),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: darkColor.withOpacity(0.05),
                            blurRadius: 8.0,
                            offset: const Offset(0, 1),
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: SvgPicture.asset(
                              "assets/icons/search.svg",
                              width: 20.0,
                              height: 20.0,
                              colorFilter: ColorFilter.mode(
                                Theme.of(context).iconTheme.color!,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context)!.search,
                            style: Theme.of(context).textTheme.bodySmall,
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
            children: [
              MenuList(tabController: _tabController),
              const Expanded(child: ProductList()),
            ],
          ),
        ),
      ),
    );
  }
}
