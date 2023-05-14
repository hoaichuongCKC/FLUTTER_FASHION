import 'package:flutter_fashion/app/models/product/product.dart';
import 'package:flutter_fashion/app/models/review_chart/review_chart_model.dart';
import 'package:flutter_fashion/export.dart';
import 'package:flutter_fashion/utils/extensions/double.dart';

class ChartReviewCpn extends StatelessWidget {
  const ChartReviewCpn({super.key, required this.data});
  final ReviewsModel data;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final ProductModel product =
        InheritedDataApp.of<ProductModel>(context)!.data;

    final star = product.star!;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            star.viewStar(),
            style: theme.textTheme.titleSmall!.copyWith(
              fontSize: 30.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(
          height: 30.0,
          child: ListView.builder(
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final disable = index + 1 > star;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: SvgPicture.asset(
                  "assets/icons/star.svg",
                  width: 60,
                  height: 30.0,
                  colorFilter: disable
                      ? ColorFilter.mode(
                          disableDarkColor.withOpacity(0.2), BlendMode.srcIn)
                      : ColorFilter.mode(
                          Colors.yellow.shade700, BlendMode.srcIn),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          'based on ${data.length} reviews',
          style: theme.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w400,
          ),
        ),
        ConstrainedBoxWidget(
          currentHeight: 0.2,
          maxHeight: 150,
          minHeight: 120.0,
          child: Column(
            children: List<Widget>.generate(
              ReviewChartModel.charts.length,
              (index) {
                final chart = ReviewChartModel.charts[index];

                final percent =
                    ((data.star_group![index].count / data.length!) * 100) /
                        100;

                return Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          chart.label,
                          style: theme.textTheme.bodySmall!.copyWith(
                            fontSize: 10.0,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: FractionallySizedBox(
                          heightFactor: 0.3,
                          alignment: Alignment.center,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  color: skeletonColor,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                      radiusBtn,
                                    ),
                                  ),
                                ),
                              ),
                              FractionallySizedBox(
                                widthFactor: percent,
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        radiusBtn,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
