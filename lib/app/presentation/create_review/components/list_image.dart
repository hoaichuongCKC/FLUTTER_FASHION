import 'package:flutter_fashion/app/blocs/create_review/create_review_cubit.dart';
import '../../../../export.dart';

class ListImageRating extends StatelessWidget {
  const ListImageRating({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateReviewCubit, CreateReviewState>(
      buildWhen: (previous, current) => previous.files != current.files,
      builder: (context, state) {
        if (state.files.isNotEmpty) {
          return Wrap(
            spacing: 5.0,
            runSpacing: 5.0,
            children: state.files
                .map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 100.0,
                          height: 100.0,
                          child: FractionallySizedBox(
                            heightFactor: 0.8,
                            child: AspectRatio(
                              aspectRatio: 1.0,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(radiusBtn),
                                ),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Image.file(
                                      item,
                                      fit: BoxFit.cover,
                                    ),
                                    IconButton(
                                      onPressed: () => context
                                          .read<CreateReviewCubit>()
                                          .deleteImage(
                                              state.files.indexOf(item)),
                                      icon: Align(
                                        alignment: const Alignment(0, 0),
                                        child: SvgPicture.asset(
                                          "assets/icons/trash.svg",
                                          width: 20.0,
                                          height: 25.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (state.files.indexOf(item) == state.files.length - 1)
                          IconButton(
                            onPressed: () => context
                                .read<CreateReviewCubit>()
                                .onSelectImage(context),
                            icon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/camera.svg",
                                ),
                                const SizedBox(width: 3.0),
                                Text(
                                  "Add photo",
                                  style: PrimaryFont.instance.copyWith(
                                    color: primaryColor,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                )
                .toList(),
          );
        }
        return SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * .2,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: lightColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(radiusBtn),
              ),
              border: Border.all(
                color: primaryColor,
              ),
            ),
            child: InkWell(
              onTap: () =>
                  context.read<CreateReviewCubit>().onSelectImage(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/icons/camera.svg",
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    AppLocalizations.of(context)!.click_here_to_choose_a_photo,
                    style: PrimaryFont.instance.copyWith(
                      fontSize: 14.0,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
