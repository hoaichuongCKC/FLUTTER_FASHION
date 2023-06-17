import 'package:flutter_fashion/app/blocs/create_review/create_review_cubit.dart';
import 'package:flutter_fashion/app/presentation/sign_up/widgets/choose_image_widget.dart';
import '../../../../export.dart';

class ListImageRating extends StatefulWidget {
  const ListImageRating({super.key});

  @override
  State<ListImageRating> createState() => _ListImageRatingState();
}

class _ListImageRatingState extends State<ListImageRating> {
  final ValueNotifier<bool> _removeNotifier = ValueNotifier(false);
  @override
  void dispose() {
    _removeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bloc = context.read<CreateReviewCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<CreateReviewCubit, CreateReviewState>(
          buildWhen: (previous, current) => previous.files != current.files,
          builder: (context, state) {
            final buttonChooseImage = ChooseImageWidget(
              isChooseMultipleImage: true,
              size: 100.0,
              color: darkColor.withOpacity(0.25),
              onListen: (files) => bloc.onSelectImage(context, files),
            );

            if (state.files.isNotEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.rating_images,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ValueListenableBuilder<bool>(
                        valueListenable: _removeNotifier,
                        builder: (context, bool isRemove, child) {
                          return GestureDetector(
                            onTap: () => _removeNotifier.value = !isRemove,
                            child: SvgPicture.asset(
                              "assets/icons/trash.svg",
                              width: 20,
                              height: 20,
                              colorFilter: const ColorFilter.mode(
                                primaryColor,
                                BlendMode.srcIn,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                      mainAxisExtent: 100.0,
                    ),
                    itemCount: state.files.length + 1,
                    itemBuilder: (context, index) {
                      if ((state.files.length + 1) - 1 == index) {
                        return buttonChooseImage;
                      }

                      final file = state.files[index];

                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(radiusBtn),
                            ),
                            child: Image.file(
                              file,
                              fit: BoxFit.cover,
                            ),
                          ),
                          ValueListenableBuilder<bool>(
                            valueListenable: _removeNotifier,
                            builder: (context, bool isRemove, child) {
                              if (!isRemove) return const SizedBox();
                              return ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(radiusBtn),
                                ),
                                child: ColoredBox(
                                  color: darkColor.withOpacity(0.25),
                                  child: IconButton(
                                    onPressed: () => bloc.deleteImage(index),
                                    icon: SvgPicture.asset(
                                      "assets/icons/trash.svg",
                                      width: 20,
                                      height: 20.0,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ],
              );
            }
            return Align(
              child: buttonChooseImage,
            );
          },
        ),
      ],
    );
  }
}
