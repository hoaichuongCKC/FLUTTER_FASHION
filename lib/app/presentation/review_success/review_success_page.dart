import 'package:flutter_fashion/app/presentation/personal_information/export.dart';
import 'package:flutter_fashion/core/base/api/api.dart';

class ReviewSuccessPage extends StatelessWidget {
  const ReviewSuccessPage({super.key, required this.indexParam});
  final int indexParam;

  @override
  Widget build(BuildContext context) {
    return AppBackgroundBlur.normal(
      isHasBackground: false,
      leading: InkWell(
        onTap: () => AppRoutes.router.go(Routes.PROFILE),
        child: const Icon(Icons.clear),
      ),
      title: AppLocalizations.of(context)!.feedback,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                return state.whenOrNull(
                  fetchCompleted: (user) => CircleAvatar(
                    radius: 60.0,
                    backgroundImage: CachedNetworkImageProvider(
                      ApiService.imageUrl + user.photo,
                      headers: getIt<ApiService>().headers,
                      cacheKey: ApiService.imageUrl + user.photo,
                    ),
                  ),
                )!;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(
                  5,
                  (index) => SvgPicture.asset("assets/icons/star.svg",
                      width: 50,
                      height: 50.0,
                      colorFilter: indexParam + 1 <= index
                          ? ColorFilter.mode(
                              darkColor.withOpacity(0.2), BlendMode.srcIn)
                          : const ColorFilter.mode(
                              warningColor, BlendMode.srcIn)),
                ).toList(),
              ),
            ),
            Text(
              AppLocalizations.of(context)!
                  .thanks_your_feedback_it_is_will_helps_us_improve_our_product,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
