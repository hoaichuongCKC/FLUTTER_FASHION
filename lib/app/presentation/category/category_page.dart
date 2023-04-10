import 'package:flutter_fashion/app/presentation/category/components/menu_list.dart';
import 'package:flutter_fashion/app/presentation/category/components/product_list.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/common/components/app/background_app.dart';

import '../../blocs/category/category_cubit.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage(
      {super.key,
      required this.searchKey,
      required this.item,
      required this.index});
  final String searchKey;
  final String item;
  final int index;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with SingleTickerProviderStateMixin {
  final bloc = getIt.get<CategoryCubit>();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: bloc.length)
      ..animateTo(
        widget.index,
        duration: const Duration(
          milliseconds: 400,
        ),
        curve: Curves.easeIn,
      );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: bloc.length,
      child: AppBackgroundBlur.withAppBar(
        leading: InkWell(
          onTap: () {},
          child: const Icon(
            Icons.arrow_back,
            size: 24.0,
          ),
        ),
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
                      boxShadow: [
                        BoxShadow(color: darkColor.withOpacity(0.15))
                      ],
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: SvgPicture.asset(
                            "assets/icons/search.svg",
                            colorFilter: ColorFilter.mode(
                                darkColor.withOpacity(0.5), BlendMode.srcIn),
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.search,
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
          children: [
            MenuList(tabController: _tabController),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: List<Widget>.generate(
                  bloc.length,
                  (index) => const ProductList(),
                ).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
