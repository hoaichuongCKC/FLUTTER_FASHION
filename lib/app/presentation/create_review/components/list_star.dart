import 'package:flutter_fashion/app/blocs/create_review/create_review_cubit.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';

import '../../../../config/svg_files.dart';

class ListStarCpn extends StatelessWidget {
  const ListStarCpn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 30.0,
          child: ListView.builder(
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: InkWell(
                  onTap: () =>
                      context.read<CreateReviewCubit>().changedStar(index),
                  borderRadius:
                      const BorderRadius.all(Radius.circular(radiusBtn)),
                  child: BlocBuilder<CreateReviewCubit, CreateReviewState>(
                    buildWhen: (previous, current) =>
                        previous.stars != current.stars,
                    builder: (context, state) {
                      final currentStar = state.stars;
                      final disableStar = currentStar < index;
                      return SvgPicture.asset(
                        Assets.starSVG,
                        width: 60,
                        height: 30.0,
                        colorFilter: disableStar
                            ? ColorFilter.mode(
                                disableDarkColor.withOpacity(0.2),
                                BlendMode.srcIn)
                            : ColorFilter.mode(
                                Colors.yellow.shade700, BlendMode.srcIn),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          AppLocalizations.of(context)!.rating_slogan,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
