import 'package:flutter_fashion/app/presentation/filter/components/title_frame.dart';
import 'package:flutter_fashion/app/presentation/filter/cubit/filter_cubit.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/core/models/range_pice/range_price.dart';

class RangePriceFrame extends StatelessWidget {
  const RangePriceFrame({super.key});

  @override
  Widget build(BuildContext context) {
    final filterCubit = context.read<FilterCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleFilterFrame(title: AppLocalizations.of(context)!.price_range),
        const SizedBox(height: 8.0),
        BlocBuilder<FilterCubit, FilterState>(
          buildWhen: (previous, current) =>
              previous.priceIndex != current.priceIndex,
          builder: (context, state) {
            final prices = state.priceRangies;
            final priceSelected = state.priceIndex;
            return Column(
              children: prices.map(
                (e) {
                  final index = prices.indexOf(e);
                  final priceLabel = e.when(
                    below100k: (priceFirst, piceSendcond) =>
                        "0 - ${piceSendcond.toDouble().toVndCurrency()}",
                    from100kTo500k: (priceFirst, piceSendcond) =>
                        "${priceFirst.toDouble().toVndCurrency()} - ${piceSendcond.toDouble().toVndCurrency()}",
                    from500kAbove: (priceFirst, piceSendcond) =>
                        "${priceFirst.toDouble().toVndCurrency()} trở lên",
                    initial: () => "",
                  );
                  return _buildItem<RangePriceModel>(
                    context,
                    title: priceLabel,
                    onTap: () => filterCubit.selectPrice(index),
                    isSelected: priceSelected == index,
                  );
                },
              ).toList(),
            );
          },
        ),
      ],
    );
  }

  ListTile _buildItem<T>(context,
      {String title = "",
      required bool isSelected,
      required VoidCallback onTap}) {
    return ListTile(
      onTap: onTap,
      leading: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: secondaryColor),
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
                color: secondaryColor,
              ),
              child: SizedBox(
                width: 15,
                height: 15,
              ),
            ),
          ),
          firstCurve: Curves.easeIn,
          secondCurve: Curves.easeIn,
          crossFadeState:
              isSelected ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        ),
      ),
      horizontalTitleGap: 0.0,
      dense: true,
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
