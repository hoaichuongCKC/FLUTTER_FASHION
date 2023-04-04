import 'package:flutter_fashion/app/blocs/create_review/create_review_cubit.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';

class ListStar extends StatelessWidget {
  const ListStar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: ListView.builder(
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => context.read<CreateReviewCubit>().changedStar(index),
            borderRadius: const BorderRadius.all(Radius.circular(radiusBtn)),
            child: BlocBuilder<CreateReviewCubit, CreateReviewState>(
              buildWhen: (previous, current) => previous.stars != current.stars,
              builder: (context, state) {
                final currentStar = state.stars;
                final disableStar = currentStar < index;
                return SvgPicture.asset("assets/icons/star.svg",
                    width: 50,
                    height: 50.0,
                    colorFilter: disableStar
                        ? ColorFilter.mode(
                            disableDarkColor.withOpacity(0.2), BlendMode.srcIn)
                        : null);
              },
            ),
          );
        },
      ),
    );
  }
}
