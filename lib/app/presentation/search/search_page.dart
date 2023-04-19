import 'package:flutter_fashion/app/blocs/search/search_cubit.dart';
import 'package:flutter_fashion/app/presentation/search/components/product_list_search.dart';
import 'package:flutter_fashion/common/components/form_search.dart';
import 'package:flutter_fashion/app/presentation/search/components/search_history.dart';
import 'package:flutter_fashion/export.dart';
import 'package:flutter_fashion/common/components/app/background_app.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackgroundBlur.withAppBar(
      actions: [
        Expanded(
          child: FormSearch(
            onFieldSubmitted: (value) {
              if (value.isEmpty) return;
              getIt.get<SearchCubit>().search(value);
            },
          ),
        ),
        TextButton(
          onPressed: () {
            AppRoutes.router.pop();
            getIt.get<SearchCubit>().reset();
          },
          child: Text(
            AppLocalizations.of(context)!.cancel,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SearchHistory(),
            ProductListSearch(),
          ],
        ),
      ),
    );
  }
}
