import 'package:flutter_fashion/app/blocs/search/search_cubit.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/core/status_cubit/status_cubit.dart';

class SearchHistory extends StatelessWidget {
  const SearchHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        final products = state.products;

        final status = state.status;

        final keywords = state.cacheKeywords;

        final keyword = state.keyword;

        if (status == AppStatus.loading || keywords.isEmpty) {
          return const SizedBox();
        }

        if (products.isNotEmpty || status == AppStatus.success) {
          return ListTile(
            contentPadding: EdgeInsets.zero,
            horizontalTitleGap: 0.0,
            dense: true,
            title: Text(
              "${AppLocalizations.of(context)!.search_keyword} \"$keyword\"",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 14.0,
                  ),
            ),
            trailing: Text(
              "${products.length} ${AppLocalizations.of(context)!.search_result}",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 14.0,
                  ),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.search_history,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                InkWell(
                  onTap: () => context.read<SearchCubit>().clearHistory(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      AppLocalizations.of(context)!.delete,
                      style: PrimaryFont.instance.copyWith(
                        fontSize: 12.0,
                        color: primaryColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10.0),
            DecoratedBox(
              decoration: const BoxDecoration(
                color: lightColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(radiusBtn / 2),
                ),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                shrinkWrap: true,
                itemCount: keywords.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final data = keywords[index];
                  return ListTile(
                    onTap: () {
                      getIt.get<SearchCubit>().search(data);
                      getIt.get<SearchCubit>().changedKeyword(data);
                    },
                    contentPadding: EdgeInsets.zero,
                    horizontalTitleGap: 0.0,
                    dense: true,
                    title: Text(
                      data,
                      style: PrimaryFont.instance.copyWith(
                        fontSize: 14.0,
                        color: darkColor,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
